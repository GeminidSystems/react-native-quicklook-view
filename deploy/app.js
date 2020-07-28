var AWS = require('aws-sdk');

var pr = require('properties-reader');
var fs = require('fs');
var plist = require('plist');
var _ = require('lodash');

var props = pr('deploy/deploy.properties');

var key = props.get('key');
var secret = props.get('secret');
var bucket = props.get('bucket');
var filePrefix = props.get('rootDir') + props.get('bundleId') + '/' + props.get('version');

var s3 = new AWS.S3({
    accessKeyId: key,
    secretAccessKey: secret
});

async function run(){


	var urls = {};

  	var ipaData = fs.readFileSync('dist/iospocs.ipa');

  	uploadFile(filePrefix + '/ReactPOC.ipa' , ipaData)
  	.then(function(r){

  		urls.ipaURL = r.Location;
  		updateManifestFile(urls.ipaURL);

  		var manifestData = fs.readFileSync('dist/manifest.plist');
  		return uploadFile(filePrefix + '/manifest.plist' , manifestData);

  	})
  	.then(function(r){

  		urls.manifestURL = r.Location;
  		var iconPath = '[no icon yet for app]';
  		var iconData = fs.readFileSync(iconPath);
  		return uploadFile(getIconPath() , iconData);

  	})
  	.then(function(){

  		var releaseNoteData = getReleaseNoteData();
		return uploadFile(props.get('rootDir') + props.get('bundleId') + '/' + props.get('version') + '/release-notes.txt' , releaseNoteData);

	})
	.then(function(){

  		console.log('');
  		console.log('DEPLOYMENT COMPLETED!');
  		console.log('');
  		console.log('IPA URL : ' + urls.ipaURL);
  		console.log('MANIFEST URL : ' + urls.manifestURL);
  		console.log('INSTALL URL : itms-services://?action=download-manifest&url=' + urls.manifestURL);
  		console.log('');

        sendAutoInvite('itms-services://?action=download-manifest&url=' + urls.manifestURL);

  	})
  	.catch(function(err){
  		console.log(err);
  	});
}

function getIconPath(){
    return props.get('rootDir') + props.get('bundleId') + '/icon.png';
}

function getReleaseNoteData(){

    var releaseNotePath = 'release_notes/' + props.get('bundleId') + '/' + props.get('version') + '.txt';
    var releaseNoteData = '';

    try {
        releaseNoteData = fs.readFileSync(releaseNotePath);
    } catch (err){
        console.log(err);
    }

    return releaseNoteData;
}

function getInviteTemplateData(){

    var templateData = '';
    try {
        templateData = fs.readFileSync('deploy/invite-email.html');
    } catch (err){
        console.log(err);
    }

    if(templateData){
        return templateData.toString();
    }

    return 'AUTO INVITE FALIED. Please contact dev@geminidsystems.com';
}

function uploadFile(fileName, fileContent){

	console.log('');
	console.log('Uploading file to AWS S3 [' + fileName + ']');

	var params = {
		Bucket : bucket,
		Key : fileName,
		Body : fileContent,
		ACL: 'public-read'
	};

	return new Promise(function(resolve, reject) {
	  	s3.upload(params, function(err, data) {
	        if (err) {
	            reject(err);
	        }
	        resolve(data);
	    });
	})
}


function updateManifestFile(ipaURL){
	var manifestObj = plist.parse(fs.readFileSync('dist/manifest.plist', 'utf8'));

	var index = 0;
	_.each(_.get(_.first(manifestObj.items), 'assets'), function(i){
		if(index === 0){
			i.url = ipaURL;
		}
		index++;
	});

	_.each(manifestObj.items, function(i){
		i.metadata.title = props.get('title');
	});

	fs.writeFileSync('dist/manifest.plist', plist.build(manifestObj));
}


function sendAutoInvite(installURL){

    if(!props.get('auto_invite')){
        return;
    }

    console.log('');
    console.log('SENDING INVITE TO : ' + props.get('auto_invite'));
    console.log('');

    var ses = new AWS.SES({
        accessKeyId: props.get('ses_key'),
        secretAccessKey: props.get('ses_secret'),
        region: props.get('ses_region')
    });

    var subject = 'You\'ve been invited to test ' + props.get('title') + ' (' + props.get('version') + ')';
    var releaseNoteData = getReleaseNoteData();
    releaseNoteData = releaseNoteData ? releaseNoteData.toString() : '';
    var iconURL = 'https://gs-poc.s3-us-west-2.amazonaws.com/icon.png';

    var htmlData = getInviteTemplateData();

    htmlData = htmlData.replace(/ICON_URL/g, iconURL);
    htmlData = htmlData.replace(/RELEASE_NOTES/g, releaseNoteData.replace(/\n/g, '<br/>'));
    htmlData = htmlData.replace(/ICON_URL/g, iconURL);
    htmlData = htmlData.replace(/APP_NAME/g, props.get('title'));
    htmlData = htmlData.replace(/APP_VERSION/g, props.get('version'));
    htmlData = htmlData.replace(/INSTALL_URL/g, installURL);

    console.log("EEMMAAIILLSS: ", props.get('auto_invite').split(','))

    var params = {
        Destination: {
            BccAddresses: [],
            CcAddresses: [],
            ToAddresses: props.get('auto_invite').split(',')
        },
        Message: {
            Body: {
                Html: {
                    Data: htmlData,
                    Charset: 'UTF-8'
                },
                Text: {
                    Charset: "UTF-8",
                    Data: ''
                }
            },
            Subject: {
                Charset: "UTF-8",
                Data: subject
            }
        },
        ReplyToAddresses: [ 'dev@geminidsystems.com' ],
        Source: "dev@geminidsystems.com",
    };

    ses.sendEmail(params, function(err, data) {
        if(!err && _.get(data, 'MessageId')){
            console.log('Message Sent [' + _.get(data, 'MessageId') + ']');
        } else {
            console.log(err);
        }
    });
}


run();

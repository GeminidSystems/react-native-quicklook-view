package com.quicklookandroid;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Build;
import android.util.Base64;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.net.URL;

public class OpenFileManager extends SimpleViewManager<OpenFileView> {
    public static final String REACT_CLASS = "OpenFileView";

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    @NonNull
    @Override
    protected OpenFileView createViewInstance(@NonNull ThemedReactContext reactContext) {
        return new OpenFileView(reactContext);
    }

    @ReactProp(name = "text")
    public void setText(OpenFileView view, String text) {
        view.setText(text);
    }

    @ReactProp(name = "source")
    public void setSource(OpenFileView view, String source) {
        FileOutputStream fos = null;
        try {
            if (source != null) {
                fos = view.getContext().openFileOutput("banana.jpeg", Context.MODE_PRIVATE);
                byte[] decodedString = android.util.Base64.decode(source , android.util.Base64.DEFAULT);
                fos.write(decodedString);
                fos.flush();
                fos.close();
                System.out.println(view.getContext().openFileInput("banana.jpeg"));
                System.out.println(view.getContext().getFileStreamPath("banana.jpeg"));
                System.out.println("Finished downloading file");
            }

        } catch (Exception e) {

        } finally {
            if (fos != null) {
                fos = null;
            }
        }
        view.setSource(Uri.fromFile(view.getContext().getFileStreamPath("banana.jpeg")));
    }

    private String encodeImage(String path)
    {
        File imagefile = new File(path);
        FileInputStream fis = null;
        try{
            fis = new FileInputStream(imagefile);
        }catch(FileNotFoundException e){
            e.printStackTrace();
        }
        Bitmap bm = BitmapFactory.decodeStream(fis);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        bm.compress(Bitmap.CompressFormat.JPEG,100,baos);
        byte[] b = baos.toByteArray();
        String encImage = Base64.encodeToString(b, Base64.DEFAULT);
        //Base64.de
        return encImage;

    }
}

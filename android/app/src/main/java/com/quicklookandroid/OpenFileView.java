package com.quicklookandroid;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.util.Base64;
import android.widget.Toast;


import androidx.annotation.RequiresApi;

import com.facebook.react.uimanager.ThemedReactContext;

import java.net.URL;
import java.util.Objects;


public class OpenFileView extends androidx.appcompat.widget.AppCompatButton {
    private static ThemedReactContext reactContext;
    public Uri source = Uri.EMPTY;

    @RequiresApi(api = Build.VERSION_CODES.N)
    OpenFileView(ThemedReactContext context) {
        super(context);
        this.reactContext = context;
        this.setText("View File");
        this.setOnClickListener(v -> {
            /*if (Objects.isNull(source.getPath()) || source.getPath().isEmpty()) {
                System.out.println(source);
                System.out.println(source.getPath());
                String errorMessage = "source is not defined";
                Toast.makeText(context.getCurrentActivity().getApplicationContext(), errorMessage, Toast.LENGTH_SHORT).show();
            }*/
            //Intent.Action_Quick_VIEW
            System.out.println(source);
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(source);
            intent.setType("image/jpeg");
            intent.removeExtra("key");
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            //intent.setType("file/*");
            context.getCurrentActivity().startActivityForResult(intent, 1);
            /*
            if (intent.resolveActivity(context.getCurrentActivity().getPackageManager()) == null) {
                String errorMessage = "no app available to complete this task";
                Toast.makeText(context.getCurrentActivity().getApplicationContext(), errorMessage, Toast.LENGTH_SHORT).show();
            } else {
                context.getCurrentActivity().startActivityForResult(intent, 1);
            }*/
        });
    }

    public void setSource(Uri url) {
        this.source = url;
    }
}

package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    Button toC, toR;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        toC = findViewById(R.id.toC);
        toR = findViewById(R.id.toR);
        toC.setOnClickListener((v) -> { startActivity(new Intent(this, MainActivity2.class)); });
        toR.setOnClickListener((v) -> { startActivity(new Intent(this, MainActivity3.class)); });
    }

}
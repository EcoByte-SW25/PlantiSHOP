package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MainActivity5 extends AppCompatActivity {

    EditText req;
    TextView res;
    Button toAD, rt, send;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main5);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Lector", "Abcd**12345");
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery("SELECT P FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
            r.next();
            if (r.getBoolean(1)) {
                r.close();
                s.close();
                c.close();
            } else {
                r.close();
                s.close();
                c.close();
                Toast.makeText(this, "Lo sentimos, NO eres un Usuario PREMIUM... por lo que NO puedes hacer uso de este APARTADO...", Toast.LENGTH_SHORT).show();
                startActivity(new Intent(this, MainActivity.class));
            }
        } catch (Exception e) {
            Toast.makeText(this, "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, MainActivity.class));
        }
        req = findViewById(R.id.req);
        res = findViewById(R.id.res);
        rt = findViewById(R.id.rt);
        rt.setOnClickListener((v) -> { startActivity(new Intent(this, MainActivity4.class)); });
        toAD = findViewById(R.id.toAD);
        toAD.setOnClickListener((v) -> { startActivity(new Intent(this, MainActivity6.class)); });
        send = findViewById(R.id.send);
        send.setOnClickListener((v) -> {

        });
    }

}
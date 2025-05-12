package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

//import com.google.android.gms.maps.GoogleMap;
//import com.google.android.gms.maps.SupportMapFragment;

public class MainActivity2 extends AppCompatActivity {

    private Connection c;
    private Statement s;
    private String u;
    //private GoogleMap map;
    //private GeoApiContext geoApiContext;
    Button bC;
    EditText ce, c1, c2, n, ap, am;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main2);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
        } catch (Exception e) {
            Toast.makeText(this, "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, MainActivity.class));
        }
        ce = findViewById(R.id.ce);
        c1 = findViewById(R.id.c1);
        c2 = findViewById(R.id.c2);
        n = findViewById(R.id.n);
        ap = findViewById(R.id.ap);
        am = findViewById(R.id.am);
        u = "";
        //geoApiContext = (new GeoApiContext).Builder().apiKey("").build();
        //SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
        /*mapFragment.getMapAsync((gm) -> {
            map = gm;
            map.setOnMapClickListener((latlng) -> {
                u = GeocodingApi.geocode(geoApiContext, latlng).await().results[0].formatted_address;
            });
        });*/
        bC = findViewById(R.id.C);
        bC.setOnClickListener((v) -> {
            try {
                ResultSet r = s.executeQuery("SELECT CE FROM Usuarios WHERE CE='"+ce.getText()+"'");
                if (ce.getText().toString().contains("@") && !r.next() && c1.getText().toString().length() > 11 && c2.getText().toString().length() > 11 && !n.getText().toString().isEmpty() && !ap.getText().toString().isEmpty() && !am.getText().toString().isEmpty() && !u.isEmpty()) {
                    r.close();
                    Hash h = new Hash();
                    s.executeUpdate("INSERT INTO Usuario(CE,C1,C2,N,AP,AM,U) VALUES ('"+ce.getText()+"','"+h.cifrar(c1.getText().toString())+"','"+h.cifrar(c2.getText().toString())+"','"+n.getText()+"','"+ap.getText()+"','"+am.getText()+"','"+h.cifrar(u)+"')");
                    s.execute("COMMIT");
                    Toast.makeText(this, "Usuario exitosamente REGISTRADO", Toast.LENGTH_SHORT).show();
                    s.close();
                    c.close();
                    //geoApiContext.shutdown();
                    startActivity(new Intent(this, MainActivity3.class));
                } else {
                    r.close();
                    Toast.makeText(this, "Registro INVALIDO", Toast.LENGTH_SHORT).show();
                }
            } catch (Exception e) {
                Toast.makeText(this, "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            }
        });
    }

}
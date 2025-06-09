package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MainActivity3 extends AppCompatActivity {

    private Connection c;
    private Statement s;
    private ResultSet r;
    private boolean k;
    Button bR;
    TextView t1, t2, t3, t4;
    EditText ce, c1, c2, cv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main3);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
        } catch (Exception e) {
            Toast.makeText(this, "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, MainActivity.class));
        }
        t1 = findViewById(R.id.t1);
        t2 = findViewById(R.id.t2);
        t3 = findViewById(R.id.t3);
        t4 = findViewById(R.id.t4);
        ce = findViewById(R.id.ce);
        c1 = findViewById(R.id.c1);
        c2 = findViewById(R.id.c2);
        cv = findViewById(R.id.cv);
        k = true;
        bR = findViewById(R.id.R);
        bR.setOnClickListener((v) -> {
            try {
                if (k) {
                    if (ce.getText().toString().contains("@") && !c1.getText().toString().isEmpty() && !c2.getText().toString().isEmpty() && !ce.getText().toString().equals(".") && !ce.getText().toString().equals(".") && !ce.getText().toString().equals(".") && !ce.getText().toString().equals(".")) {
                        r = s.executeQuery("SELECT FhN1,FhN2,I1,I2,C1,C2,FfS FROM Usuario WHERE CE='"+ce.getText()+"'");
                        if (r.next()) {
                            if (r.getTimestamp(1) != null) { if (r.getTimestamp(1).before(Timestamp.valueOf(LocalDateTime.now().format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))))) {
                                s.executeUpdate("UPDATE Usuario SET I1=5,FhN1=NULL WHERE CE='"+ce.getText()+"'");
                                s.execute("COMMIT");
                            } }
                            if (r.getTimestamp(2) != null) { if (r.getTimestamp(2).before(Timestamp.valueOf(LocalDateTime.now().format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))))) {
                                s.executeUpdate("UPDATE Usuario SET I2=2,FhN2=NULL WHERE CE='"+ce.getText()+"'");
                                s.execute("COMMIT");
                            } }
                            if (r.getDate(7) != null) { if (r.getDate(7).before(Date.valueOf(LocalDateTime.now().toLocalDate().format(DateTimeFormatter.ofPattern("uuuu-MM-dd"))))) {
                                s.executeUpdate("UPDATE Usuario SET P=FALSE,FfS=NULL WHERE CE='"+ce.getText()+"'");
                                s.execute("COMMIT");
                            } }
                        }
                        if (r.first() && r.getByte(3) > 0 && r.getByte(4) > 0 && r.getFetchSize() == 1) {
                            Hash h = new Hash();
                            if (c1.getText().toString().equals(h.descifrar(r.getString(5))) && c2.getText().toString().equals(h.descifrar(r.getString(6)))) {
                                Cortes vv = new Cortes();
                                String cV = vv.cV();
                                s.executeUpdate("UPDATE Usuario SET CV='"+cV+"' WHERE CE='"+ce.getText()+"'");
                                Epistula e = new Epistula();
                                e.eMail(ce.getText().toString(), "Código de Verificación", cV);
                                Toast.makeText(this, "Para Acceder, ingresa el Codigo de Verificación de 10 Digitos que enviamos a tu Correo ELECTRONICO", Toast.LENGTH_LONG).show();
                                t1.setVisibility(View.GONE);
                                ce.setVisibility(View.GONE);
                                t2.setVisibility(View.GONE);
                                c1.setVisibility(View.GONE);
                                t3.setVisibility(View.GONE);
                                c2.setVisibility(View.GONE);
                                t4.setVisibility(View.VISIBLE);
                                cv.setVisibility(View.VISIBLE);
                                k = false;
                            } else {
                                if (r.getByte(3) == 1) { s.executeUpdate("UPDATE Usuario SET FhN1='"+LocalDateTime.now().plusDays(1L).format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE CE='"+ce.getText()+"'"); }
                                s.executeUpdate("UPDATE Usuario SET I1="+(r.getByte(3) - 1)+" WHERE CE='"+ce.getText()+"'");
                                Toast.makeText(this, ("Contraseña(s) INCORRECTA(S)\nIntentos RESTANTES: " + (r.getByte(3) - 1)), Toast.LENGTH_LONG).show();
                            }
                            s.execute("COMMIT");
                        } else {
                            Toast.makeText(this, "Usuario INVALIDO", Toast.LENGTH_SHORT).show();
                            r.close();
                            s.close();
                            c.close();
                            startActivity(new Intent(this, MainActivity.class));
                        }
                    } else {
                        Toast.makeText(this, "Ingreso INVALIDO", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    if (!cv.getText().toString().isEmpty()) {
                        r = s.executeQuery("SELECT CV,I2 FROM Usuario WHERE CE='"+ce.getText()+"'");
                        r.next();
                        if (cv.getText().toString().equals(r.getString(1))) {
                            Cortes.sesion = ce.getText().toString();
                            s.executeUpdate("UPDATE Usuario SET CV=NULL,I1=5,FhN1=NULL,I2=2,FhN2=NULL WHERE CE='"+ce.getText()+"'");
                            s.execute("COMMIT");
                            Toast.makeText(this, "¡Bienvenido a PlantiSHOP!", Toast.LENGTH_SHORT).show();
                            r.close();
                            s.close();
                            c.close();
                            startActivity(new Intent(this, MainActivity4.class));
                        } else {
                            if (r.getByte(2) == 1) { s.executeUpdate("UPDATE Usuario SET FhN2='"+LocalDateTime.now().plusDays(2L).format(DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE CE='"+ce.getText()+"'"); }
                            s.executeUpdate("UPDATE Usuario SET CV=NULL,I2="+(r.getByte(2) - 1)+" WHERE CE='"+ce.getText()+"'");
                            Toast.makeText(this, ("Verificación INCORRECTA\nIntentos RESTANTES: " + (r.getByte(2) - 1)), Toast.LENGTH_LONG).show();
                            t1.setVisibility(View.VISIBLE);
                            ce.setVisibility(View.VISIBLE);
                            ce.setText("");
                            t2.setVisibility(View.VISIBLE);
                            c1.setVisibility(View.VISIBLE);
                            c1.setText("");
                            t3.setVisibility(View.VISIBLE);
                            c2.setVisibility(View.VISIBLE);
                            c2.setText("");
                            t4.setVisibility(View.GONE);
                            cv.setVisibility(View.GONE);
                            cv.setText("");
                            k = true;
                            s.execute("COMMIT");
                        }
                    } else {
                        Toast.makeText(this, "Ingreso INVALIDO", Toast.LENGTH_SHORT).show();
                    }
                }
            } catch (Exception e) {
                Toast.makeText(this, "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            }
        });
    }

}
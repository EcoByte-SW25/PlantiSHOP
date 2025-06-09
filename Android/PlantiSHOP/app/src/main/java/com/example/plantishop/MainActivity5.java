package com.example.plantishop;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.activity.result.contract.ActivityResultContract;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import org.json.JSONObject;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.DataOutputStream;
import java.net.URL;
import java.net.HttpURLConnection;

public class MainActivity5 extends AppCompatActivity {

    EditText req;
    TextView res;
    Button toAD, rt, send, aIMG;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main5);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Lector", "Abcd**12345");
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery("SELECT P FROM Usuario WHERE CE='"+Cortes.sesion+"'");
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
            try {
                HttpURLConnection c = (HttpURLConnection) (new URL("https://api.openai.com/v1/chat/completions")).openConnection();
                c.setRequestMethod("POST");
                c.setDoOutput(true);
                c.setRequestProperty("Authorization", "/*Llave de OpenAI*/");
                c.setRequestProperty("Content-Type", "application/json");
                try (OutputStream out = c.getOutputStream()) {
                    byte[] json = ("{\"model\"=\"gpt-3.5-turbo\",\"messages\"=[{\"role\"=\"system\",\"content\"=\"Eres un asistente virtual especializado en el cuidado de plantas. Tu trabajo es ayudar a los usuarios a cuidar mejor sus plantas.\nSolo debes responder a preguntas que estén relacionadas con plantas, jardinería, botánica o temas similares. Si el usuario te pregunta algo que no esté relacionado con plantas, responde educadamente que solo puedes ayudar en temas de jardinería y cuidado de plantas.\nSiempre pide al usuario que te diga qué planta tiene y qué desea saber sobre ella, para poder ayudarlo mejor.\"},{\"role\"=\"user\",\"content\"=\""+req.getText()+"\"}]}").getBytes(StandardCharsets.UTF_8);
                    out.write(json, 0, json.length);
                }
                String res = "";
                try (BufferedReader bfrd = new BufferedReader(new InputStreamReader(c.getInputStream(), StandardCharsets.UTF_8))) {
                    String aux;
                    while ((aux = bfrd.readLine()) != null) {
                        res += aux.trim();
                    }
                }
                this.res.setText((new JSONObject(res)).getJSONArray("choices").getJSONObject(0).getJSONObject("message").getString("content"));
            } catch (Exception e) {
                Toast.makeText(this, "Lo lamento, ha ocurrido un ERROR... intentalo de NUEVO...", Toast.LENGTH_SHORT).show();
            }
        });
        aIMG = findViewById(R.id.aIMG);
        aIMG.setOnClickListener((v) -> {
            registerForActivityResult(new ActivityResultContract<>() {
                @Override
                public Object parseResult(int i, @Nullable Intent intent) { return intent; }

                @NonNull
                @Override
                public Intent createIntent(@NonNull Context context, Object o) {
                    return (new Intent(Intent.ACTION_OPEN_DOCUMENT)).addCategory(Intent.CATEGORY_OPENABLE).setTypeAndNormalize("image/jpeg");
                }
            }, (o) -> {
                if (o != null) {
                    try {
                        HttpURLConnection c = (HttpURLConnection) (new URL("https://my-api.plantnet.org/v2/identify/all\\*Llave de PlantNET*\\")).openConnection();
                        c.setRequestMethod("POST");
                        c.setDoOutput(true);
                        String boundary = "===" + System.currentTimeMillis() + "===";
                        c.setRequestProperty("Content-Type", ("multipart/form-data; boundary=" + boundary));
                        try (DataOutputStream out = new DataOutputStream(c.getOutputStream())) {
                            out.writeBytes("--" + boundary + "\r\n");
                            out.writeBytes("Content-Disposition: form-data; name=\"images\"; filename=\"planta.jpg\"\r\n");
                            out.writeBytes("Content-Type: image/jpeg\r\n\r\n");
                            try (InputStream img = getApplicationContext().getContentResolver().openInputStream(((Intent) o).getData())) {
                                byte[] buffer = new byte[4096];
                                int aux;
                                while ((aux = img.read(buffer)) >= 0) {
                                    out.write(buffer, 0, aux);
                                }
                            }
                            out.writeBytes("\r\n--" + boundary + "--\r\n");
                        }
                        String res = "";
                        try (BufferedReader bfrd = new BufferedReader(new InputStreamReader(c.getInputStream()))) {
                            String aux;
                            while ((aux = bfrd.readLine()) != null) {
                                res += aux;
                            }
                        }
                        JSONObject json = new JSONObject(res);
                        String opts = "";
                        for (byte i = 0; i < ((byte) Math.min(3, json.getJSONArray("results").length())); i++) {
                            opts += "\nNombre Cientifico de la Plantación: '" + json.getJSONArray("results").getJSONObject(i).getJSONObject("species").getString("scientificNameWithoutAuthor") + "' (" + (json.getJSONArray("results").getJSONObject(i).getDouble("score") * 100d) + "% de CERTEZA)";
                        }
                        this.res.setText(opts);
                    } catch (Exception e) {
                        Toast.makeText(this, "Lo lamento, ha ocurrido un ERROR... intentalo de NUEVO...", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(this, "Basil.IA necesita una IMAGEN para poder ANALIZARLA", Toast.LENGTH_SHORT).show();
                }
            }).launch(null);
        });
    }

}
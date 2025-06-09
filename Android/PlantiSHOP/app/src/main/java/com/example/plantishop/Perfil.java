package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

//import com.google.android.gms.maps.GoogleMap;
//import com.google.android.gms.maps.SupportMapFragment;

public class Perfil extends Fragment {

    public Perfil() {}

    private Connection c;
    private Statement s;
    private ResultSet r;
    private String u;
    private Hash h;
    //private GoogleMap map;
    //private GeoApiContext geoApiContext;
    TextView txtCE, txtU;
    EditText n, ap, am, c1, c2, nc1, nc2;
    Button bN, bAP, bAM, bU, bnC1, bnC2, bDel;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
            r = s.executeQuery("SELECT N,AP,AM,U FROM Usuario WHERE CE='"+Cortes.sesion+"'");
            h = new Hash();
            txtCE = container.findViewById(R.id.txtCE);
            txtCE.setText(Cortes.sesion);
            txtU = container.findViewById(R.id.txtU);
            n = container.findViewById(R.id.n);
            ap = container.findViewById(R.id.ap);
            am = container.findViewById(R.id.am);
            r.next();
            n.setText(r.getString(1));
            ap.setText(r.getString(2));
            am.setText(r.getString(3));
            txtU.setText(u = h.descifrar(r.getString(4)));
            c1 = container.findViewById(R.id.c1);
            c2 = container.findViewById(R.id.c2);
            nc1 = container.findViewById(R.id.nc1);
            nc2 = container.findViewById(R.id.nc2);
            //geoApiContext = (new GeoApiContext).Builder().apiKey("").build();
            //SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager().findFragmentById(R.id.map);
            /*mapFragment.getMapAsync((gm) -> {
                map = gm;
                map.setOnMapClickListener((latlng) -> {
                    u = GeocodingApi.geocode(geoApiContext, latlng).await().results[0].formatted_address;
                });
            });*/
            bN = container.findViewById(R.id.bN);
            bN.setOnClickListener((v) -> {
                try {
                    if (!n.getText().toString().isEmpty()) {
                        s.executeUpdate("UPDATE Usuario SET N='"+n.getText()+"' WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                    } else {
                        Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            bAP = container.findViewById(R.id.bAP);
            bAP.setOnClickListener((v) -> {
                try {
                    if (!ap.getText().toString().isEmpty()) {
                        s.executeUpdate("UPDATE Usuario SET AP='"+ap.getText()+"' WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                    } else {
                        Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            bAM = container.findViewById(R.id.bAM);
            bAM.setOnClickListener((v) -> {
                try {
                    if (!am.getText().toString().isEmpty()) {
                        s.executeUpdate("UPDATE Usuario SET AM='"+am.getText()+"' WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                    } else {
                        Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            bU = container.findViewById(R.id.bU);
            bU.setOnClickListener((v) -> {
                try {
                    if (!u.isEmpty()) {
                        s.executeUpdate("UPDATE Usuario SET U='"+h.cifrar(u)+"' WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                        txtU.setText(u);
                    } else {
                        Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            bnC1 = container.findViewById(R.id.bnC1);
            bnC1.setOnClickListener((v) -> {
                try {
                    r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+Cortes.sesion+"'");
                    r.next();
                    if (c1.getText().toString().equals(h.descifrar(r.getString(1))) && c2.getText().toString().equals(h.descifrar(r.getString(2))) && nc1.getText().toString().length() > 11) {
                        s.executeUpdate("UPDATE Usuario SET C1='"+h.cifrar(nc1.getText().toString())+"' WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                        Toast.makeText(getActivity(), "Contraseña exitosamente ACTUALIZADA", Toast.LENGTH_SHORT).show();
                    } else {
                        Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            bnC2 = container.findViewById(R.id.bnC2);
            bnC2.setOnClickListener((v) -> {
                try {
                    r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+Cortes.sesion+"'");
                    r.next();
                    if (c1.getText().toString().equals(h.descifrar(r.getString(1))) && c2.getText().toString().equals(h.descifrar(r.getString(2))) && nc2.getText().toString().length() > 11) {
                        s.executeUpdate("UPDATE Usuario SET C2='"+h.cifrar(nc2.getText().toString())+"' WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                        Toast.makeText(getActivity(), "Contraseña de Respaldo exitosamente ACTUALIZADA", Toast.LENGTH_SHORT).show();
                    } else {
                        Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            bDel = container.findViewById(R.id.bDel);
            bDel.setOnClickListener((v) -> {
                try {
                    r = s.executeQuery("SELECT C1,C2 FROM Usuario WHERE CE='"+Cortes.sesion+"'");
                    r.next();
                    if (c1.getText().toString().equals(h.descifrar(r.getString(1))) && c2.getText().toString().equals(h.descifrar(r.getString(2)))) {
                        s.executeUpdate("DELETE FROM Usuario WHERE CE='"+Cortes.sesion+"'");
                        s.execute("COMMIT");
                        Toast.makeText(getActivity(), "Usuario exitosamente ELIMINADO", Toast.LENGTH_SHORT).show();
                        Cortes.sesion = null;
                        startActivity(new Intent(getActivity(), MainActivity.class));
                    } else {
                        Toast.makeText(getActivity(), "Eliminación INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            throw new RuntimeException(e);
        }
        return inflater.inflate(R.layout.fragment_perfil, container, false);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        try {
            r.close();
            s.close();
            c.close();
            //geoApiContext.shutdown();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
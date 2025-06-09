package com.example.plantishop;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Arboles extends Fragment {

    public Arboles() {}

    private Connection c;
    private Statement s;
    private ResultSet r;
    ListView list;
    ArrayList<Long> id;
    ArrayList<Float> p;
    ArrayList<String> img, nP, d;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://192.168.1.66/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
            r = s.executeQuery("SELECT Producto.Img,Producto.Id,Producto.N,Producto.P,Producto.D,Usuario.N,Usuario.AP,Usuario.AM,Producto.Cupo FROM Producto INNER JOIN Usuario ON Producto.CE=Usuario.CE WHERE Producto.T='A' AND Producto.Cupo>0 ORDER BY Producto.Pop DESC,Producto.Cupo DESC LIMIT 50");
            list = container.findViewById(R.id.list);
            img = new ArrayList<>();
            id = new ArrayList<>();
            nP = new ArrayList<>();
            p = new ArrayList<>();
            d = new ArrayList<>();
            while (r.next()) {
                img.add(r.getString(1));
                id.add(r.getLong(2));
                nP.add(r.getString(3));
                p.add(r.getFloat(4));
                d.add("Vendedor: " + r.getString(6) + " " + r.getString(7) + " " + r.getString(8) + "\nCupo: " + r.getInt(9) + (r.getString(5) == null ? "" : ("\n"+r.getString(5))));
            }
            list.setAdapter(new XAdaptador(getActivity(), img, nP, p, d));
            list.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long identifier) {
                    try {
                        r = s.executeQuery("SELECT CE,N,D,P,Img,Cupo FROM Producto WHERE Id="+id.get(position));
                        r.next();
                        s.executeUpdate("INSERT INTO Compra(V,C,NP,DP,PP,ImgP,X,LP) VALUES ('"+r.getString(1)+"','"+Cortes.sesion+"','"+r.getString(2)+"','"+r.getString(3)+"',"+r.getFloat(4)+",'"+r.getString(5)+"',1,"+((r.getInt(6) < 100) ? r.getInt(6) : 0)+")");
                        s.execute("COMMIT");
                        Toast.makeText(getActivity(), "Producto COMPRADO", Toast.LENGTH_SHORT).show();
                    } catch (Exception e) {
                        Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {}
            });
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            throw new RuntimeException(e);
        }
        return inflater.inflate(R.layout.fragment_arboles, container, false);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        try {
            r.close();
            s.close();
            c.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
package com.example.plantishop;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Ventas extends Fragment {

    public Ventas() {}

    private Connection c;
    private Statement s;
    private long id;
    ListView list;
    Button bUD;
    RadioButton rU, rD;
    EditText n, txt, p;
    ArrayList<Long> $id;
    ArrayList<Float> $p;
    ArrayList<String> $n, $txt, up;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
            ResultSet r = s.executeQuery("SELECT Id,N,D,P,Img FROM Productos WHERE CE='"+Cortes.sesion+"' ORDER BY Pop DESC LIMIT 50");
            list = container.findViewById(R.id.list);
            $id = new ArrayList<>();
            $n = new ArrayList<>();
            $txt = new ArrayList<>();
            $p = new ArrayList<>();
            up = new ArrayList<>();
            while (r.next()) {
                $id.add(r.getLong(1));
                $n.add(r.getString(2));
                $txt.add(r.getString(3));
                $p.add(r.getFloat(4));
                up.add(r.getString(5));
            }
            r.close();
            list.setAdapter(new XAdaptador(getActivity(), up, $n, $p, $txt));
            n = container.findViewById(R.id.n);
            txt = container.findViewById(R.id.d);
            p = container.findViewById(R.id.p);
            rU = container.findViewById(R.id.rU);
            rD = container.findViewById(R.id.rD);
            bUD = container.findViewById(R.id.bUD);
            bUD.setOnClickListener((v) -> {
                try {
                    if (bUD.getText().toString().equals("ACTUALIZAR")) {
                        if (!n.getText().toString().isEmpty() && Float.parseFloat(p.getText().toString()) >= 1f && Float.parseFloat(p.getText().toString()) <= 1000000f) {
                            s.executeUpdate("UPDATE Producto SET N='"+n.getText()+"',D="+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+",P="+p.getText()+" WHERE Id="+id);
                            s.execute("COMMIT");
                            Toast.makeText(getActivity(), "Producto correctamente ACTUALIZADO", Toast.LENGTH_SHORT).show();
                            getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                        } else {
                            Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                        }
                    } else {
                        s.executeUpdate("DELETE FROM Producto WHERE Id="+id);
                        s.execute("COMMIT");
                        Toast.makeText(getActivity(), "Producto correctamente ELIMINADO", Toast.LENGTH_SHORT).show();
                        getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            list.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long identifier) {
                    if (rU.isSelected()) {
                        bUD.setText("ACTUALIZAR");
                        bUD.setBackgroundColor(getResources().getColor(R.color.blue, null));
                        id = $id.get(position);
                        n.setText($n.get(position));
                        txt.setText($txt.get(position));
                        p.setText(String.valueOf($p.get(position).floatValue()));
                    } else if (rD.isSelected()) {
                        bUD.setText("ELIMINAR");
                        bUD.setBackgroundColor(getResources().getColor(R.color.red, null));
                        id = $id.get(position);
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {}
            });
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            throw new RuntimeException(e);
        }
        return inflater.inflate(R.layout.fragment_ventas, container, false);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        try {
            s.close();
            c.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
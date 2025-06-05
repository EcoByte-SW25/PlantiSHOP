package com.example.plantishop;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.Spinner;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class Jardin extends Fragment {

    public Jardin() {}

    private Connection c;
    private Statement s;
    private long id;
    ListView list;
    Spinner t;
    Button bCUD;
    RadioButton rU, rD;
    EditText n, txt, l, p;
    ArrayList<Long> $id;
    ArrayList<Integer> img;
    ArrayList<Float> $l;
    ArrayList<Byte> $p;
    ArrayList<String> $n, $txt;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
            ResultSet r = s.executeQuery("SELECT Id,N,T,C,L,P FROM Jardines WHERE CE='"+Cortes.sesion+"' ORDER BY P DESC LIMIT 50");
            list = container.findViewById(R.id.list);
            $id = new ArrayList<>();
            $n = new ArrayList<>();
            img = new ArrayList<>();
            $txt = new ArrayList<>();
            $l = new ArrayList<>();
            $p = new ArrayList<>();
            while (r.next()) {
                $id.add(r.getLong(1));
                $n.add(r.getString(2));
                switch (r.getString(3)) {
                    case "PD": { img.add(R.drawable.pd); } break;
                    case "PH": { img.add(R.drawable.ph); } break;
                    case "PA": { img.add(R.drawable.pa); } break;
                    case "A": { img.add(R.drawable.a); } break;
                    case "AH": { img.add(R.drawable.ah); } break;
                }
                $txt.add(r.getString(4));
                $l.add(r.getFloat(5));
                $p.add(r.getByte(6));
            }
            r.close();
            list.setAdapter(new XAdaptador(getActivity(), img, $n, $l, $p, $txt));
            n = container.findViewById(R.id.n);
            txt = container.findViewById(R.id.c);
            l = container.findViewById(R.id.l);
            p = container.findViewById(R.id.p);
            rU = container.findViewById(R.id.rU);
            rD = container.findViewById(R.id.rD);
            t = container.findViewById(R.id.t);
            t.setAdapter(new ArrayAdapter<>(getActivity(), android.R.layout.simple_list_item_1, new String[]{"Planta Decorativa", "Planta de Huerto", "Planta Acuatica", "Arbol", "Alga u Hongo"}));
            bCUD = container.findViewById(R.id.bCUD);
            bCUD.setOnClickListener((v) -> {
                try {
                    switch (bCUD.getText().toString()) {
                        case "REGISTRAR": {
                            ResultSet rs = s.executeQuery("SELECT Id FROM Jardines WHERE CE='"+Cortes.sesion+"' AND N='"+n.getText()+"'");
                            if (!rs.next() && !n.getText().toString().isEmpty() && t.getSelectedItemPosition() >= 0 && Float.parseFloat(l.getText().toString()) >= 0 && Float.parseFloat(l.getText().toString()) <= 100f && Byte.parseByte(p.getText().toString()) > 0 && Byte.parseByte(p.getText().toString()) < 11) {
                                switch (t.getSelectedItemPosition()) {
                                    case 0: {
                                        s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,L,P) VALUES ('"+Cortes.sesion+"','"+n.getText()+"','PD',"+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+","+l.getText()+","+p.getText()+")");
                                    } break;
                                    case 1: {
                                        s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,L,P) VALUES ('"+Cortes.sesion+"','"+n.getText()+"','PH',"+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+","+l.getText()+","+p.getText()+")");
                                    } break;
                                    case 2: {
                                        s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,L,P) VALUES ('"+Cortes.sesion+"','"+n.getText()+"','PA',"+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+","+l.getText()+","+p.getText()+")");
                                    } break;
                                    case 3: {
                                        s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,L,P) VALUES ('"+Cortes.sesion+"','"+n.getText()+"','A',"+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+","+l.getText()+","+p.getText()+")");
                                    } break;
                                    case 4: {
                                        s.executeUpdate("INSERT INTO Jardin(CE,N,T,C,L,P) VALUES ('"+Cortes.sesion+"','"+n.getText()+"','AH',"+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+","+l.getText()+","+p.getText()+")");
                                    } break;
                                }
                                s.execute("COMMIT");
                                Toast.makeText(getActivity(), "Plantación correctamente REGISTRADA", Toast.LENGTH_SHORT).show();
                            } else {
                                Toast.makeText(getActivity(), "Registro INVALIDO", Toast.LENGTH_SHORT).show();
                            }
                            rs.close();
                        } break;
                        case "ACTUALIZAR": {
                            if (!n.getText().toString().isEmpty() && Float.parseFloat(l.getText().toString()) >= 0 && Float.parseFloat(l.getText().toString()) <= 100f && Byte.parseByte(p.getText().toString()) > 0 && Byte.parseByte(p.getText().toString()) < 11) {
                                s.executeUpdate("UPDATE Jardin SET N='"+n.getText()+"',C="+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+",L="+l.getText()+",P="+p.getText()+" WHERE Id="+id);
                                s.execute("COMMIT");
                                Toast.makeText(getActivity(), "Plantación correctamente ACTUALIZADA", Toast.LENGTH_SHORT).show();
                                getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                            } else {
                                Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                            }
                        } break;
                        case "ELIMINAR": {
                            s.executeUpdate("DELETE FROM Jardin WHERE Id="+id);
                            s.execute("COMMIT");
                            Toast.makeText(getActivity(), "Plantación correctamente ELIMINADA", Toast.LENGTH_SHORT).show();
                            getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                        } break;
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
            list.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long identifier) {
                    if (rU.isSelected()) {
                        bCUD.setText("ACTUALIZAR");
                        bCUD.setTextColor(getResources().getColor(R.color.white, null));
                        bCUD.setBackgroundColor(getResources().getColor(R.color.blue, null));
                        id = $id.get(position);
                        n.setText($n.get(position));
                        txt.setText($txt.get(position));
                        l.setText(String.valueOf($l.get(position).floatValue()));
                        p.setText(String.valueOf($p.get(position).byteValue()));
                    } else if (rD.isSelected()) {
                        bCUD.setText("ELIMINAR");
                        bCUD.setTextColor(getResources().getColor(R.color.white, null));
                        bCUD.setBackgroundColor(getResources().getColor(R.color.red, null));
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
        return inflater.inflate(R.layout.fragment_jardin, container, false);
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
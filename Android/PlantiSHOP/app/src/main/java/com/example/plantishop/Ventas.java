package com.example.plantishop;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.activity.result.contract.ActivityResultContract;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
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

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.nio.file.Files;

public class Ventas extends Fragment {

    public Ventas() {}

    private Connection c;
    private Statement s;
    private ResultSet r;
    private long id;
    ListView list;
    Button bCUD;
    RadioButton rU, rD;
    EditText n, txt, p;
    Spinner t;
    ArrayList<Long> $id;
    ArrayList<Float> $p;
    ArrayList<String> $n, $txt, up;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
            r = s.executeQuery("SELECT Id,N,D,P,Img FROM Productos WHERE CE='"+Cortes.sesion+"' ORDER BY Pop DESC LIMIT 50");
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
            list.setAdapter(new XAdaptador(getActivity(), up, $n, $p, $txt));
            n = container.findViewById(R.id.n);
            txt = container.findViewById(R.id.d);
            t = container.findViewById(R.id.t);
            t.setAdapter(new ArrayAdapter<>(getActivity(), android.R.layout.simple_expandable_list_item_1, new String[]{"Planta Decorativa", "Planta de Huerto", "Planta Acuatica", "Arbol", "Alga u Hongo", "Fertilizante", "Herramienta"}));
            p = container.findViewById(R.id.p);
            rU = container.findViewById(R.id.rU);
            rD = container.findViewById(R.id.rD);
            bCUD = container.findViewById(R.id.bCUD);
            bCUD.setOnClickListener((v) -> {
                try {
                    switch (bCUD.getText().toString()) {
                        case "REGISTRAR": {
                            registerForActivityResult(new ActivityResultContract<>() {
                                @Override
                                public Object parseResult(int i, @Nullable Intent intent) { return intent; }

                                @NonNull
                                @Override
                                public Intent createIntent(@NonNull Context context, Object o) {
                                    return (new Intent(Intent.ACTION_OPEN_DOCUMENT)).addCategory(Intent.CATEGORY_OPENABLE).setTypeAndNormalize("image/*");
                                }
                            }, (o) -> {
                                if (o != null) {
                                    try {
                                        r = s.executeQuery("SELECT Img FROM Productos WHERE Img='"+((Intent) o).getData().getLastPathSegment()+"'");
                                        if (!r.next() && ((Intent) o).getData().getLastPathSegment() != null && !n.getText().toString().isEmpty() && Float.parseFloat(p.getText().toString()) >= 1f && Float.parseFloat(p.getText().toString()) <= 5000000f) {
                                            switch (t.getSelectedItemPosition()) {
                                                case 0: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'PD',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                                case 1: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'PH',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                                case 2: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'PA',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                                case 3: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'A',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                                case 4: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'AH',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                                case 5: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'F',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                                case 6: {
                                                    s.executeUpdate("INSERT INTO Producto(CE,N,D,T,P,Img) VALUES ('"+Cortes.sesion+"','"+n.getText()+"',"+(txt.getText().toString().isEmpty() ? null : ("'"+txt.getText()+"'"))+",'H',"+p.getText()+",'"+((Intent) o).getData().getLastPathSegment()+"')");
                                                } break;
                                            }
                                            s.execute("COMMIT");
                                            Files.copy((new File(((Intent) o).getDataString())).toPath(), (new File(".", ((Intent) o).getData().getLastPathSegment())).toPath());
                                            Toast.makeText(getActivity(), "Producto subido EXITOSAMENTE", Toast.LENGTH_SHORT).show();
                                        } else {
                                            Toast.makeText(getActivity(), "Registro INVALIDO", Toast.LENGTH_SHORT).show();
                                        }
                                    } catch (Exception e) {
                                        Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                                    }
                                } else {
                                    Toast.makeText(getActivity(), "Registro INVALIDO", Toast.LENGTH_SHORT).show();
                                }
                            }).launch(null);
                        } break;
                        case "ACTUALIZAR": {
                            if (!n.getText().toString().isEmpty() && Float.parseFloat(p.getText().toString()) >= 1f && Float.parseFloat(p.getText().toString()) <= 1000000f) {
                                s.executeUpdate("UPDATE Producto SET N='"+n.getText()+"',D="+(txt.getText().toString().isEmpty() ? null : "'"+txt.getText()+"'")+",P="+p.getText()+" WHERE Id="+id);
                                s.execute("COMMIT");
                                Toast.makeText(getActivity(), "Producto correctamente ACTUALIZADO", Toast.LENGTH_SHORT).show();
                                getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                            } else {
                                Toast.makeText(getActivity(), "Actualización INVALIDA", Toast.LENGTH_SHORT).show();
                            }
                        } break;
                        case "ELIMINAR": {
                            s.executeUpdate("DELETE FROM Producto WHERE Id="+id);
                            s.execute("COMMIT");
                            r = s.executeQuery("SELECT Img FROM Productos WHERE Id="+id);
                            r.next();
                            Files.delete((new File(".", r.getString(1))).toPath());
                            Toast.makeText(getActivity(), "Producto correctamente ELIMINADO", Toast.LENGTH_SHORT).show();
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
                        p.setText(String.valueOf($p.get(position).floatValue()));
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
        return inflater.inflate(R.layout.fragment_ventas, container, false);
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
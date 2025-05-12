package com.example.plantishop;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.activity.result.contract.ActivityResultContract;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Mensajeria extends Fragment {

    public Mensajeria() {}

    private Connection c;
    private Statement s;
    private ResultSet r;
    private long id;
    private float $pP;
    private Hash h;
    private File fT;
    ListView ps, ss;
    TextView txt;
    EditText l, $tP, uC;
    DatePicker fC;
    TimePicker hC;
    Button b1;
    RadioButton ac, rc, cf, cn;
    private ArrayList<Long> id1, id2;
    private ArrayList<Byte> x, lP;
    private ArrayList<Float> pP, tP;
    private ArrayList<Boolean> bMsg;
    private ArrayList<String> imgP, nP, dP, vc, fh, u;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            txt = container.findViewById(R.id.txt);
            l = container.findViewById(R.id.l);
            $tP = container.findViewById(R.id.tP);
            l.setOnKeyListener((v, tecla, ev) -> {
                try {
                    ev.setSource(tecla);
                    $tP.setText(String.format("%.2f", (Float.parseFloat(l.getText().toString()) * $pP)));
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Solo NÚMEROS", Toast.LENGTH_SHORT).show();
                }
                return true;
            });
            uC = container.findViewById(R.id.uC);
            fC = container.findViewById(R.id.fC);
            hC = container.findViewById(R.id.hC);
            b1 = container.findViewById(R.id.b1);
            ac = container.findViewById(R.id.ac);
            rc = container.findViewById(R.id.rc);
            cf = container.findViewById(R.id.cf);
            cn = container.findViewById(R.id.cn);
            h = new Hash();
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            s = c.createStatement();
            r = s.executeQuery("SELECT Compras.ImgP,Compras.NP,Compras.PP,Compras.DP,Usuarios.N,Usuarios.AP,Usuarios.AM,Compras.X,Compras.LP,Compras.TP,Compras.Fh,Compras.U,Compras.Id FROM Compras INNER JOIN Usuarios ON Compras.C=Usuarios.CE WHERE Compras.V='"+Cortes.sesion+"' ORDER BY Compras.X, Compras.Fh");
            ss = container.findViewById(R.id.ss);
            imgP = new ArrayList<>();
            nP = new ArrayList<>();
            pP = new ArrayList<>();
            dP = new ArrayList<>();
            vc = new ArrayList<>();
            x = new ArrayList<>();
            lP = new ArrayList<>();
            tP = new ArrayList<>();
            fh = new ArrayList<>();
            u = new ArrayList<>();
            id2 = new ArrayList<>();
            while (r.next()) {
                if (r.getByte(8) != 1) {
                    imgP.add(r.getString(1));
                    nP.add(r.getString(2));
                    pP.add(r.getFloat(3));
                    dP.add(r.getString(4));
                    vc.add("Vendedor: " + r.getString(5) + " " + r.getString(6) + " " + r.getString(7));
                    x.add(r.getByte(8));
                    lP.add(r.getByte(9));
                    tP.add(r.getFloat(10));
                    fh.add(LocalDateTime.parse(r.getString(11), DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toString().toUpperCase());
                    u.add(h.descifrar(r.getString(12)));
                    id2.add(r.getLong(13));
                }
            }
            ss.setAdapter(new XAdaptador(getActivity(), imgP, nP, pP, dP, vc, x, lP, tP, fh, u));
            ss.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                    try {
                        r = s.executeQuery("SELECT X FROM Compras WHERE Id="+id2.get(position));
                        r.next();
                        if (r.getByte(1) == 2) {
                            if (ac.isSelected()) {
                                s.executeUpdate("UPDATE Compra SET X=3,BMsg=FALSE WHERE Id="+id2.get(position));
                                s.execute("COMMIT");
                            } else if (rc.isSelected()) {
                                s.executeUpdate("UPDATE Compra SET X=1,LP=0,TP=0.00,U=NULL,Fh=NULL,BMsg=TRUE WHERE Id="+id2.get(position));
                                s.execute("COMMIT");
                            }
                        }
                    } catch (Exception e) {
                        Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {}
            });
            fT = new File(getActivity().getCacheDir(), "f.txt");
            fT.createNewFile();
            r = s.executeQuery("SELECT * FROM Notificaciones WHERE V='"+Cortes.sesion+"'");
            while (r.next()) {
                Toast.makeText(getActivity(), (r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+" ha "+(r.getBoolean(6) ? "ACEPTADO" : "CANCELADO")+" este Pedido: "+r.getString(7)), Toast.LENGTH_LONG).show();
                if (r.getBoolean(6)) {
                    registerForActivityResult(new ActivityResultContract<>() {
                        @Override
                        public Object parseResult(int i, @Nullable Intent intent) {
                            return null;
                        }

                        @NonNull
                        @Override
                        public Intent createIntent(@NonNull Context context, Object o) {
                            Intent dwld = new Intent(Intent.ACTION_CREATE_DOCUMENT);
                            try {
                                FileOutputStream w = new FileOutputStream(fT);
                                w.write(("Registro Comercial\n\nProducto: "+r.getString(7)+"\nComprador: "+r.getString(3)+" "+r.getString(4)+" "+r.getString(5)+"\nNo. de Lotes: "+r.getByte(8)+"\nCosto: $"+r.getFloat(9)+"\nFecha y Hora: "+LocalDateTime.parse(r.getString(10), DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toString().toUpperCase()+"\nUbicacion: "+h.descifrar(r.getString(11))).getBytes(StandardCharsets.UTF_8));
                                w.flush();
                                w.close();
                                w = null;
                                dwld.addCategory(Intent.CATEGORY_OPENABLE);
                                dwld.setDataAndTypeAndNormalize(Uri.fromFile(fT), "text/plain");
                                dwld.putExtra(Intent.EXTRA_TITLE, ("venta"+r.getLong(1)+".txt"));
                            } catch (Exception e) {
                                throw new RuntimeException(e);
                            }
                            return dwld;
                        }
                    }, (o) -> {}).launch(null);
                }
            }
            if (r.first()) {
                s.executeUpdate("DELETE FROM Notificacion WHERE V='"+Cortes.sesion+"'");
                s.execute("COMMIT");
            }
            r = s.executeQuery("SELECT Compras.ImgP,Compras.NP,Compras.PP,Compras.DP,Usuarios.N,Usuarios.AP,Usuarios.AM,Compras.X,Compras.BMsg,Compras.Id FROM Compras INNER JOIN Usuarios ON Compras.V=Usuarios.CE WHERE Compras.C='"+Cortes.sesion+"' ORDER BY Compras.X DESC, Compras.Fh ASC");
            ps = container.findViewById(R.id.ps);
            imgP = new ArrayList<>();
            nP = new ArrayList<>();
            pP = new ArrayList<>();
            dP = new ArrayList<>();
            vc = new ArrayList<>();
            x = new ArrayList<>();
            bMsg = new ArrayList<>();
            id1 = new ArrayList<>();
            while (r.next()) {
                imgP.add(r.getString(1));
                nP.add(r.getString(2));
                pP.add(r.getFloat(3));
                dP.add(r.getString(4));
                vc.add("Comprador: " + r.getString(5) + " " + r.getString(6) + " " + r.getString(7));
                x.add(r.getByte(8));
                bMsg.add(r.getBoolean(9));
                id1.add(r.getLong(10));
            }
            ps.setAdapter(new XAdaptador(getActivity(), imgP, nP, pP, dP, vc, x, bMsg));
            ps.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
                @Override
                public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                    try {
                        if (x.get(position) == 1) {
                            id = id1.get(position);
                            txt.setText(nP.get(position));
                            l.setText("1");
                            $pP = pP.get(position);
                            $tP.setText(String.valueOf(pP.get(position).floatValue()));
                            r = s.executeQuery("SELECT U FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
                            r.next();
                            uC.setText(h.descifrar(r.getString(1)));
                        } else if (x.get(position) == 3) {
                            if (cf.isSelected() || cn.isSelected()) {
                                r = s.executeQuery("SELECT N,AP,AM FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
                                r.next();
                                String[] $c = {r.getString(1), r.getString(2), r.getString(3)};
                                r = s.executeQuery("SELECT Productos.Pop,Productos.Id,Usuarios.CE,Usuarios.N,Usuarios.AP,Usuarios.AM,Compras.NP,Compras.LP,Compras.TP,Compras.Fh,Compras.U FROM Productos (INNER JOIN Usuarios ON Productos.CE=Usuarios.CE (INNER JOIN Compras ON Usuarios.CE=Compras.V)) WHERE Compras.C='"+Cortes.sesion+"' AND Compras.Id="+id1.get(position));
                                r.next();
                                if (cf.isSelected()) {
                                    s.executeUpdate("UPDATE Producto SET Pop="+(r.getLong(1) + 1L)+" WHERE Id="+r.getLong(2));
                                    s.executeUpdate("INSERT INTO Notificacion(V,C,APC,AMC,N,P,LP,TP,Fh,U) VALUES ('"+r.getString(3)+"','"+$c[0]+"','"+$c[1]+"','"+$c[2]+"',TRUE,'"+r.getString(7)+"',"+r.getByte(8)+","+r.getFloat(9)+",'"+r.getString(10)+"','"+h.cifrar(r.getString(11))+"')");
                                    registerForActivityResult(new ActivityResultContract<>() {
                                        @Override
                                        public Object parseResult(int i, @Nullable Intent intent) {
                                            return null;
                                        }

                                        @NonNull
                                        @Override
                                        public Intent createIntent(@NonNull Context context, Object o) {
                                            Intent dwld = new Intent(Intent.ACTION_CREATE_DOCUMENT);
                                            try {
                                                FileOutputStream w = new FileOutputStream(fT);
                                                w.write(("Registro Comercial\n\nProducto: "+r.getString(7)+"\nVendedor: "+r.getString(4)+" "+r.getString(5)+" "+r.getString(6)+"\nComprador: "+$c[0]+" "+$c[1]+" "+$c[2]+"\nNo. de Lotes: "+r.getByte(8)+"\nCosto: $"+r.getFloat(9)+"\nFecha y Hora: "+LocalDateTime.parse(r.getString(10), DateTimeFormatter.ofPattern("d / MMM / uuuu -- h:mm a")).toString().toUpperCase()+"\nUbicacion: "+h.descifrar(r.getString(11))).getBytes(StandardCharsets.UTF_8));
                                                w.flush();
                                                w.close();
                                                w = null;
                                                dwld.addCategory(Intent.CATEGORY_OPENABLE);
                                                dwld.setDataAndTypeAndNormalize(Uri.fromFile(fT), "text/plain");
                                                dwld.putExtra(Intent.EXTRA_TITLE, ("compra"+id1.get(position)+".txt"));
                                            } catch (Exception e) {
                                                throw new RuntimeException(e);
                                            }
                                            return dwld;
                                        }
                                    }, (o) -> {}).launch(null);
                                } else {
                                    s.executeUpdate("INSERT INTO Notificacion(V,C,APC,AMC,N,P) VALUES ('"+r.getString(3)+"','"+$c[0]+"','"+$c[1]+"','"+$c[2]+"',FALSE,'"+r.getString(7)+"')");
                                }
                                s.executeUpdate("DELETE FROM Compra WHERE Id="+id1.get(position));
                                s.execute("COMMIT");
                            }
                        }
                    } catch (Exception e) {
                        Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onNothingSelected(AdapterView<?> parent) {}
            });
            fC.setMinDate(LocalDateTime.now().toEpochSecond(ZoneOffset.UTC) * 1000L);
            b1.setOnClickListener((v) -> {
                try {
                    if (Byte.parseByte(l.getText().toString()) > 0 && Byte.parseByte(l.getText().toString()) < 101 && !uC.getText().toString().isEmpty()) {
                        s.executeUpdate("UPDATE Compra SET X=2,LP="+l.getText()+",TP="+$tP.getText()+",U='"+h.cifrar(uC.getText().toString())+"',Fh='"+LocalDateTime.parse((fC.getYear()+"-"+(fC.getMonth() + 1)+"-"+fC.getDayOfMonth()+" "+hC.getHour()+":"+hC.getMinute()+":00"), DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss"))+"' WHERE Id="+id);
                    } else {
                        Toast.makeText(getActivity(), "Compra INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            throw new RuntimeException(e);
        }
        return inflater.inflate(R.layout.fragment_mensajeria, container, false);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        try {
            r.close();
            s.close();
            c.close();
            fT.delete();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
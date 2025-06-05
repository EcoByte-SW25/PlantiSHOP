package com.example.plantishop;

import android.content.Intent;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Locale;
import java.time.LocalDate;
import java.time.format.TextStyle;
import org.rosuda.JRI.Rengine;
import org.rosuda.REngine.JRI.JRIEngine;

public class MainActivity6 extends AppCompatActivity {

    Button toIA, rt;
    ImageView vpm, dpp, iaalldt;
    TextView total, moda, plus, promd, promd2, future;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main6);
        total = findViewById(R.id.total);
        moda = findViewById(R.id.moda);
        plus = findViewById(R.id.plus);
        promd = findViewById(R.id.promd);
        promd2 = findViewById(R.id.promd2);
        future = findViewById(R.id.future);
        vpm = findViewById(R.id.vpm);
        dpp = findViewById(R.id.dpp);
        iaalldt = findViewById(R.id.iaalldt);
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            Connection c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery("SELECT P FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
            r.next();
            if (r.getBoolean(1)) {
                r = s.executeQuery("SELECT TP FROM Compras WHERE V='"+Cortes.sesion+"' AND X=4 ORDER BY TP");
                boolean cv;
                double x_md, g_h, vt, i, sp, x, dt, md;
                String mo, xVM, yVM, lDP, vDP, xIAlT, yIAlT;
                x_md = x = md = g_h = vt = i = sp = 0;
                dt = 1d;
                cv = true;
                if (r.getFetchSize() > 0) {
                    g_h = 1d;
                    while (r.next()) {
                        vt += r.getDouble(1);
                        g_h *= r.getDouble(1);
                    }
                    x_md = x = vt / r.getFetchSize();
                    g_h = Math.pow(g_h, (1d / r.getFetchSize()));
                    if ((r.getFetchSize() - 1) % 2 == 0) {
                        r.absolute((r.getFetchSize() - 1) / 2);
                        md = r.getDouble(1);
                    } else {
                        r.absolute(Math.floorDiv((r.getFetchSize() - 1), 2));
                        md = r.getDouble(1);
                        r.next();
                        md = (md + r.getDouble(1)) / 2;
                    }
                    r.beforeFirst();
                    dt = 0;
                    while (r.next()) {
                        dt += Math.pow((x_md - r.getDouble(1)), 2);
                    }
                    dt = Math.sqrt(dt / ((r.getFetchSize() > 30) ? r.getFetchSize() : (r.getFetchSize() - 1)));
                    if (dt / x_md > 0.3d) {
                        cv = false;
                        x_md = md;
                        r.beforeFirst();
                        g_h = 0;
                        while (r.next()) {
                            g_h += 1d / r.getDouble(1);
                        }
                        g_h = r.getFetchSize() / g_h;
                    }
                }
                r = s.executeQuery("SELECT N,Pop FROM Productos WHERE CE='"+Cortes.sesion+"' AND Pop>0 ORDER BY Pop DESC");
                mo = "NINGUNO";
                lDP = "\"Sin DATOS\"";
                vDP = "0";
                if (r.getFetchSize() > 0) {
                    mo = lDP = vDP = "";
                    while (r.next()) {
                        lDP += "\"" + r.getString(1) + "\",";
                        vDP += r.getLong(2) + ",";
                    }
                    lDP = lDP.substring(0, (lDP.length() - 2));
                    vDP = vDP.substring(0, (vDP.length() - 2));
                    r.beforeFirst();
                    long n, pop;
                    n = pop = 0;
                    while (r.next() && r.getLong(2) >= pop) {
                        n = n + 1L;
                        pop = r.getLong(2);
                        mo += "\n\t- "+r.getString(1);
                    }
                    if (n == 1L) {
                        sp = (x - pop) / dt;
                    } else if (n == r.getFetchSize()) {
                        mo = "TODOS";
                    } else {
                        sp = (3d * (x - md)) / dt;
                    }
                }
                xVM = yVM = xIAlT = yIAlT = "";
                for (byte m = 6; m > 0; m--) {
                    r = s.executeQuery("SELECT TP FROM Compras WHERE V='"+Cortes.sesion+"' AND X=4 AND Fh>='"+LocalDate.now().minusMonths(m).withDayOfMonth(1)+" 00:00:00' AND Fh<'"+LocalDate.now().minusMonths(m - 1).withDayOfMonth(1)+" 00:00:00'");
                    if (r.getFetchSize() > 0) {
                        x = 0;
                        while (r.next()) {
                            x += r.getDouble(1);
                        }
                        xVM += x + ",";
                    } else {
                        xVM += "0,";
                    }
                    yVM += "\"" + LocalDate.now().minusMonths(m).getMonth().getDisplayName(TextStyle.FULL, Locale.forLanguageTag("es-MX")) + "\",";
                }
                xVM = xVM.substring(0, (xVM.length() - 2));
                yVM = yVM.substring(0, (yVM.length() - 2));
                x = 0;
                for (byte sm = 16; sm > 0; sm--) {
                    r = s.executeQuery("SELECT TP FROM Compras WHERE V='"+Cortes.sesion+"' AND X=4 AND Fh>='"+LocalDate.now().minusWeeks(sm)+" 00:00:00' AND Fh<'"+LocalDate.now().minusWeeks(sm - 1)+" 00:00:00'");
                    while (r.next()) {
                        x += r.getDouble(1);
                    }
                    xIAlT += x + ",";
                    yIAlT += "\"-" + sm + "S\",";
                }
                xIAlT = xIAlT.substring(0, (xIAlT.length() - 2));
                yIAlT = yIAlT.substring(0, (yIAlT.length() - 2));
                r = s.executeQuery("SELECT A FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
                r.next();
                i = vt - r.getDouble(1);
                s.executeUpdate("UPDATE Usuario SET A="+vt+" WHERE CE='"+Cortes.sesion+"'");
                s.execute("COMMIT");
                JRIEngine rJ = new JRIEngine(Rengine.getMainEngine());
                byte[] vm, dp, ialt;
                vm = rJ.createRJavaRef(Rengine.getMainEngine().eval("barplot(c("+xVM+"),names.arg=c("+yVM+"),main=\"Ventas por Mes\",xlab=\"Numero de Ventas\",col=c(\"green\"),horiz=TRUE)")).asBytes();
                dp = rJ.createRJavaRef(Rengine.getMainEngine().eval("pie(c("+vDP+"),label=c("+lDP+"),main=\"Distribucion por Producto\")")).asBytes();
                ialt = rJ.createRJavaRef(Rengine.getMainEngine().eval("barplot(c("+xIAlT+"),names.arg=c("+yIAlT+"),main=\"Ingresos Acumulados a lo largo del Tiempo\",xlab=\"Ingresos Acumulados\",ylab=\"Semanas\",col=c(\"blue\"),horiz=TRUE)")).asBytes();
                rJ.close();
                vpm.setImageBitmap(BitmapFactory.decodeByteArray(vm, 0, (vm.length - 1)));
                dpp.setImageBitmap(BitmapFactory.decodeByteArray(dp, 0, (dp.length - 1)));
                iaalldt.setImageBitmap(BitmapFactory.decodeByteArray(ialt, 0, (ialt.length - 1)));
                total.setText("Ventas Totales: $ " + vt);
                moda.setText("Producto(s) más Vendido(s):" + mo);
                plus.setText("Ingresos: +$ " + i);
                promd.setText("Promedio de Ventas: $ " + x_md);
                promd2.setText("Promedio " + (cv ? "Geometrico" : "Armonico") + " de Ventas: $ " + g_h);
                if (sp > 0) {
                    future.setText("La Distribución de tus Ventas tiene una Tendencia Positiva, por lo que tus Indices de Venta son Altos y, probablemente, si Continuas con la Metodologia Comercial que has estado Implementando, seguiras Obteniendo Buenas Ganancias en el Futuro Cercano ;D");
                } else if (sp == 0) {
                    future.setText("La Distribución de tus Ventas es Normal y tus Indices de Venta estan dentro de lo Ordinario, por lo que no hay Tendencias Significativas, asi que tal vez Deberias de Revisar tu Metodologia Comercial para que, de esta manera, Mejores tus Ganancias en el Futuro :3");
                } else {
                    future.setText("La Distribución de tus Ventas tiene una Tendencia Negativa, por lo que tus Indices de Venta son Bajos, asi que Debes de Modificar tu Metodologia Comercial Actual, tal vez Debas de Publicar otro Tipo de Productos, Hacerlos más Atractivos o Regular los Precios de tu Mercancia Actual, de esta manera, probablemente, Mejores tus Ganancias en el Futuro Cercano ;3");
                }
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
        rt = findViewById(R.id.rt);
        rt.setOnClickListener((v) -> { startActivity(new Intent(this, MainActivity4.class)); });
        toIA = findViewById(R.id.toIA);
        toIA.setOnClickListener((v) -> { startActivity(new Intent(this, MainActivity5.class)); });
    }

}
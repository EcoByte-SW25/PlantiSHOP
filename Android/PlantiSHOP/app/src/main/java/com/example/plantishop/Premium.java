package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class Premium extends Fragment {

    public Premium() {}

    private Connection c;
    private Statement statement;
    TextView msg, msgU;
    EditText clabe, n, tel;
    Spinner s;
    CheckBox ac;
    Button bS, bIA, bAD;
    LinearLayout no, yes;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            c = DriverManager.getConnection("jdbc:mysql://host/PSHOP", "Crud", "PlantiSHOP-+CrUd*/https:02468.!?");
            statement = c.createStatement();
            ResultSet r = statement.executeQuery("SELECT P,FfS,N,AP,AM FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
            if (r.getBoolean(1)) {
                no = container.findViewById(R.id.no);
                no.setVisibility(View.GONE);
                bIA = container.findViewById(R.id.bIA);
                bIA.setOnClickListener((v) -> { startActivity(new Intent(getActivity(), MainActivity5.class)); });
                bAD = container.findViewById(R.id.bAD);
                bAD.setOnClickListener((v) -> { startActivity(new Intent(getActivity(), MainActivity6.class)); });
                msg = container.findViewById(R.id.msg);
                msg.setText("Tu Suscripción termina el "+LocalDate.parse(r.getString(2), DateTimeFormatter.ofPattern("E, d / MMM / uuuu")).toString().toUpperCase());
                if (LocalDate.now().until(LocalDate.parse(r.getString(2)), ChronoUnit.DAYS) <= 8L) {
                    msgU = container.findViewById(R.id.msgU);
                    msgU.setText("¡Faltan "+LocalDate.now().until(LocalDate.parse(r.getString(2)), ChronoUnit.DAYS)+" días para que termine tu Suscripción!");
                }
            } else {
                yes = container.findViewById(R.id.yes);
                yes.setVisibility(View.GONE);
                clabe = container.findViewById(R.id.clabe);
                n = container.findViewById(R.id.n);
                tel = container.findViewById(R.id.tel);
                s = container.findViewById(R.id.s);
                ac = container.findViewById(R.id.ac);
                bS = container.findViewById(R.id.bS);
                bS.setOnClickListener((v) -> {
                    if (clabe.getText().toString().length() == 18 && n.getText().toString().length() == 16 && tel.getText().toString().length() == 10 && s.getSelectedItem() != null && ac.isChecked()) {
                        //
                        Toast.makeText(getActivity(), "Suscripción correctamente REALIZADA", Toast.LENGTH_SHORT).show();
                        getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                    } else {
                        Toast.makeText(getActivity(), "Suscripción INVALIDA", Toast.LENGTH_SHORT).show();
                    }
                });
            }
            r.close();
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            throw new RuntimeException(e);
        }
        return inflater.inflate(R.layout.fragment_premium, container, false);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        try {
            statement.close();
            c.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
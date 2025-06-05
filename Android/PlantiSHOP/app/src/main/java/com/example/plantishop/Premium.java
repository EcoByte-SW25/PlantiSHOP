package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
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
import java.math.BigDecimal;
/*
import mx.openpay.client.core.OpenpayAPI;
import mx.openpay.client.Customer;
import mx.openpay.client.BankAccount;
import mx.openpay.client.core.requests.transactions.CreateBankPayoutParams;
*/

public class Premium extends Fragment {

    public Premium() {}

    private Connection c;
    private Statement statement;
    private ResultSet r;
    TextView msg, msgU;
    EditText clabe, tel;
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
            r = statement.executeQuery("SELECT P,FfS FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
            r.next();
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
                tel = container.findViewById(R.id.tel);
                s = container.findViewById(R.id.s);
                s.setAdapter(new ArrayAdapter<>(getActivity(), android.R.layout.simple_expandable_list_item_1, new String[]{
                        "Mensual (30 días).- $",
                        "Trimestral (3 meses).- $",
                        "Semestral (6 meses).- $",
                        "Anual (365 días).- $"
                }));
                ac = container.findViewById(R.id.ac);
                bS = container.findViewById(R.id.bS);
                bS.setOnClickListener((v) -> {
                    try {
                        if (clabe.getText().toString().length() == 18 && tel.getText().toString().length() == 10 && s.getSelectedItemPosition() >= 0 && ac.isChecked()) {
                            r = statement.executeQuery("SELECT N,AP,AM FROM Usuarios WHERE CE='"+Cortes.sesion+"'");
                            r.next();
                            //OpenpayAPI api = new OpenpayAPI("https://api.openpay.mx", "", "");
                            switch (s.getSelectedItemPosition()) {
                                case 0: {
                                    statement.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusDays(30L)+"' WHERE CE='"+Cortes.sesion+"'");
                                    //api.payouts().create(api.customers().create((new Customer()).name(r.getString(1)).lastName(r.getString(2)).email(Cortes.sesion).phoneNumber(tel.getText().toString()).clabe(clabe.getText().toString())).getId(), (new CreateBankPayoutParams()).bankAccount((new BankAccount()).clabe("").holderName("").alias("EcoByte")).amount(new BigDecimal("")).description("Yo, "+r.getString(1)+" "+r.getString(2)+" "+r.getString(3)+" ("+Cortes.sesion+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP"));
                                } break;
                                case 1: {
                                    statement.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusMonths(3L)+"' WHERE CE='"+Cortes.sesion+"'");
                                    //api.payouts().create(api.customers().create((new Customer()).name(r.getString(1)).lastName(r.getString(2)).email(Cortes.sesion).phoneNumber(tel.getText().toString()).clabe(clabe.getText().toString())).getId(), (new CreateBankPayoutParams()).bankAccount((new BankAccount()).clabe("").holderName("").alias("EcoByte")).amount(new BigDecimal("")).description("Yo, "+r.getString(1)+" "+r.getString(2)+" "+r.getString(3)+" ("+Cortes.sesion+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP"));
                                } break;
                                case 2: {
                                    statement.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusMonths(6L)+"' WHERE CE='"+Cortes.sesion+"'");
                                    //api.payouts().create(api.customers().create((new Customer()).name(r.getString(1)).lastName(r.getString(2)).email(Cortes.sesion).phoneNumber(tel.getText().toString()).clabe(clabe.getText().toString())).getId(), (new CreateBankPayoutParams()).bankAccount((new BankAccount()).clabe("").holderName("").alias("EcoByte")).amount(new BigDecimal("")).description("Yo, "+r.getString(1)+" "+r.getString(2)+" "+r.getString(3)+" ("+Cortes.sesion+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP"));
                                } break;
                                case 3: {
                                    statement.executeUpdate("UPDATE Usuario SET P=TRUE,FfS='"+LocalDate.now().plusYears(1L)+"' WHERE CE='"+Cortes.sesion+"'");
                                    //api.payouts().create(api.customers().create((new Customer()).name(r.getString(1)).lastName(r.getString(2)).email(Cortes.sesion).phoneNumber(tel.getText().toString()).clabe(clabe.getText().toString())).getId(), (new CreateBankPayoutParams()).bankAccount((new BankAccount()).clabe("").holderName("").alias("EcoByte")).amount(new BigDecimal("")).description("Yo, "+r.getString(1)+" "+r.getString(2)+" "+r.getString(3)+" ("+Cortes.sesion+"), Acepto y Confirmo esta Transferencia Bancaria a EcoByte, realizada el día "+LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/uuuu"))+", para el uso del Apartado PREMIUM de PlantiSHOP"));
                                } break;
                            }
                            statement.execute("COMMIT");
                            Toast.makeText(getActivity(), "Suscripción realizada EXITOSAMENTE\n¡Bienvenido al Apartado PREMIUM de PlantiSHOP!", Toast.LENGTH_LONG).show();
                            getParentFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                        } else {
                            Toast.makeText(getActivity(), "Suscripción INVALIDA", Toast.LENGTH_SHORT).show();
                        }
                    } catch (Exception e) {
                        Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                    }
                });
            }
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
            r.close();
            statement.close();
            c.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
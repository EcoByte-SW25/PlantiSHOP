package com.example.plantishop;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Toast;

public class Faq extends Fragment {

    public Faq() {}

    ListView pfa;
    Button toEB;
    EditText com;

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        try {
            pfa = container.findViewById(R.id.pfa);
            pfa.setAdapter(new ArrayAdapter<String>(getActivity(), android.R.layout.simple_expandable_list_item_1, new String[]{"¿?\n\n."}));
            com = container.findViewById(R.id.com);
            toEB = container.findViewById(R.id.toEB);
            toEB.setOnClickListener((v) -> {
                try {
                    if (!com.getText().toString().isEmpty()) {
                        Epistula e = new Epistula();
                        e.eMail("ecobyte.sw@gmail.com", Cortes.sesion, com.getText().toString());
                        Toast.makeText(getActivity(), "Comentario ENVIADO... Gracias por tu Cooperación ;3", Toast.LENGTH_SHORT).show();
                    }
                } catch (Exception e) {
                    Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
                }
            });
        } catch (Exception e) {
            Toast.makeText(getActivity(), "Lo sentimos, ha ocurrido un ERROR... intentalo de NUEVO", Toast.LENGTH_SHORT).show();
            throw new RuntimeException(e);
        }
        return inflater.inflate(R.layout.fragment_faq, container, false);
    }

}
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
            pfa.setAdapter(new ArrayAdapter<>(getActivity(), android.R.layout.simple_expandable_list_item_1, new String[]{
                    "¿Que es PlantiSHOP?\n\nEs una Aplicación, tanto Web como Móvil, dirigida a aquellas personas que les gusta la Jardineria, y que le proporciona a estos usuarios un Jardin Virtual y un Mercado Digital, ademas de un Analista de Datos y una Inteligencia Artificial",
                    "¿Como funciona el Jardin Personal?\n\nEs un Repositorio en el que los usuarios Registran y Consultan las Plantaciones que estos tienen en sus Casas, Huertos o Jardines Fisicos, ademas del Estado en el que estas mismas Plantaciones se encuentran en la actualidad",
                    "¿Como se Comercializa en PlantiSHOP?\n\n1. En el modulo del Mercado apareceran todos los Productos que se encuentren disponibles, y el usuario escogera el o los Productos que mas le agraden :3\n2. En el modulo de la Mensajeria apareceran todos los Productos que el usuario haya Registrado en su Cuenta, y el usuario habra de mandarle al Vendedor la Cantidad del Producto Requerido, y el Lugar, la Fecha y la Hora del Encuentro Presencial en el que se llevara a cabo la Compra/Venta del Producto ;3\n3. El Vendedor vera la Solicitud del Cliente; si la Acepta entonces este proceso podra Avanzar a la ultima fase, pero si la Rechaza entonces el Cliente debera de Regresar a la fase anterior :3\n4. Por ultimo, el Cliente debera de decidir si Confirma o Cancela el Pedido; si lo Cancela entonces se le Notificara al Vendedor y el Pedido sera Eliminado, pero si la Confirma entonces se les Descargara a ambas partes un Archivo con todos los Datos de la Compra/Venta para que este Validada y se pueda llevar a cabo el Encuentro Presencial de la manera Correcta ;3",
                    "¿Que es el Apartado PREMIUM?\n\nEs un Apartado Especial dentro de la Aplicación al que solo pueden Ingresar aquellos usuarios que hayan Pagado una Suscripción PREMIUM, y dentro del cual se encuentran tanto el Analista de Datos como la Inteligencia Artificial que ofrece esta Aplicación :D",
                    "¿Que es Basil.IA?\n\nEs la Inteligencia Artificial de PlantiSHOP, mas especificamente, se trata de un Asistente Personal de Jardineria (ChatBot) con el cual los usuarios PREMIUM pueden Solucionar sus Dudas y pedirle Consejos en temas relacionados con la Jardineria; ademas, Basil.IA tambien es capaz de Reconocer Plantaciones con el uso de una simple Imagen en formato JPEG",
                    "¿Como funciona el Analista Estadistico-Predictivo de PlantiSHOP?\n\nEs un Algoritmo que hace uso de la Estadistica para Generar Resultados, Graficar Progresos y Realizar Predicciones Futuras Aproximadas sobre las Actividades Comerciales de los usuarios PREMIUM y del Mercado General de PlantiSHOP :3"
            }));
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
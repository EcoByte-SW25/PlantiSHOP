package com.example.plantishop;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import android.graphics.BitmapFactory;

import java.util.ArrayList;

public class XAdaptador extends BaseAdapter {

    @SuppressWarnings("FieldMayBeFinal")
    private LayoutInflater inflater;
    private ArrayList<Integer> img;
    private ArrayList<Float> l, $p, $t;
    private ArrayList<Byte> p, nL;
    private ArrayList<Boolean> bM;
    @SuppressWarnings("FieldMayBeFinal")
    private ArrayList<String> up, n, cd, vc, fh, u;

    public XAdaptador(Context context, ArrayList<Integer> img, ArrayList<String> n, ArrayList<Float> l, ArrayList<Byte> p, ArrayList<String> cd) {
        this.img = img;
        this.n = n;
        this.l = l;
        this.p = p;
        this.cd = cd;
        inflater = LayoutInflater.from(context);
    }

    public XAdaptador(Context context, ArrayList<String> up, ArrayList<String> n, ArrayList<Float> $p, ArrayList<String> cd) {
        this.up = up;
        this.n = n;
        this.$p = $p;
        this.cd = cd;
        inflater = LayoutInflater.from(context);
    }

    public XAdaptador(Context context, ArrayList<String> up, ArrayList<String> n, ArrayList<Float> $p, ArrayList<String> cd, ArrayList<String> vc, ArrayList<Byte> p, ArrayList<Boolean> bM) {
        this.up = up;
        this.n = n;
        this.$p = $p;
        this.cd = cd;
        this.vc = vc;
        this.p = p;
        this.bM = bM;
        inflater = LayoutInflater.from(context);
    }

    public XAdaptador(Context context, ArrayList<String> up, ArrayList<String> n, ArrayList<Float> $p, ArrayList<String> cd, ArrayList<String> vc, ArrayList<Byte> p, ArrayList<Byte> nL, ArrayList<Float> $t, ArrayList<String> fh, ArrayList<String> u) {
        this.up = up;
        this.n = n;
        this.$p = $p;
        this.cd = cd;
        this.vc = vc;
        this.p = p;
        this.nL = nL;
        this.$t = $t;
        this.fh = fh;
        this.u = u;
        inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return n.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        convertView = inflater.inflate(R.layout.lamina, null);
        ImageView img = convertView.findViewById(R.id.lamIMG);
        TextView n = convertView.findViewById(R.id.lamN);
        TextView etc = convertView.findViewById(R.id.lamETC);
        TextView cd = convertView.findViewById(R.id.lamC_D);
        TextView msg = convertView.findViewById(R.id.lamMSG);
        if (this.img == null) {
            img.setImageBitmap(BitmapFactory.decodeFile("."+up.get(position)));
            if (vc == null) {
                etc.setText("$ " + $p.get(position));
                msg.setVisibility(View.GONE);
            } else {
                etc.setText("$ " + $p.get(position) + "\n" + vc.get(position));
                if (bM == null) {
                    if (p.get(position) == 2) {
                        msg.setText("Número de Lotes a Comprar: "+nL.get(position)+"\nPrecio Total: $"+$t.get(position)+"\nFecha y Hora de la Compra: "+fh.get(position)+"\nLugar de la Compra: "+u.get(position));
                    } else {
                        msg.setText("Esperando a que el Comprador analice tu Respuesta...");
                    }
                } else {
                    switch (p.get(position)) {
                        case 1: {
                            msg.setText((bM.get(position) ? "El Vendedor ha Rechazado tu Solicitud... intentalo de NUEVO...\n" : "") + "Producto REGISTRADO... ahora, Ingresa el Número de Lotes que quieres Comprar, asi como la Fecha, la Hora y el Lugar en donde se Realizara la Compra...\nY ENVIALE esos Datos al VENDEDOR");
                        } break;
                        case 2: {
                            msg.setText("Esperando a que el Vendedor analice tu Solicitud...");
                        } break;
                        case 3: {
                            msg.setText("¡El Vendedor ha Aceptado tu Solicitud!");
                        } break;
                    }
                }
            }
        } else {
            img.setImageResource(this.img.get(position));
            etc.setText("Nivel de Prioridad: " + p.get(position) + "\nPorcentaje de Luz Recibida: " + l.get(position) + " %");
            msg.setVisibility(View.GONE);
        }
        n.setText(this.n.get(position));
        cd.setText(this.cd.get(position));
        return convertView;
    }

}
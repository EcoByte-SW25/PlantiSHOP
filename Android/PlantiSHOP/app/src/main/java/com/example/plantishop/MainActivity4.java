package com.example.plantishop;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.fragment.app.Fragment;

import com.google.android.material.navigation.NavigationView;

public class MainActivity4 extends AppCompatActivity {

    DrawerLayout drawerLayout;
    NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main4);
        drawerLayout = findViewById(R.id.main);
        setSupportActionBar(findViewById(R.id.toolbar));
        ActionBarDrawerToggle drawerToggle = new ActionBarDrawerToggle(this, drawerLayout, findViewById(R.id.toolbar), R.string.Open, R.string.Close);
        drawerLayout.addDrawerListener(drawerToggle);
        drawerToggle.syncState();
        if (savedInstanceState == null) {
            try {
                getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
            } catch (Exception e) {
                Cortes.sesion = null;
                startActivity(new Intent(this, MainActivity3.class));
            }
        }
        navigationView = findViewById(R.id.nav);
        navigationView.setNavigationItemSelectedListener((mi) -> {
            drawerLayout.closeDrawer(GravityCompat.START);
            try {
                if (mi.getItemId() == R.id.perfil) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_perfil)).commit();
                } else if (mi.getItemId() == R.id.jardin) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_jardin)).commit();
                } else if (mi.getItemId() == R.id.fin) {
                    Cortes.sesion = null;
                    startActivity(new Intent(this, MainActivity.class));
                } else if (mi.getItemId() == R.id.mPD) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_p_decorativas)).commit();
                } else if (mi.getItemId() == R.id.mPH) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_p_huerto)).commit();
                } else if (mi.getItemId() == R.id.mPA) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_p_acuaticas)).commit();
                } else if (mi.getItemId() == R.id.mA) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_arboles)).commit();
                } else if (mi.getItemId() == R.id.mAH) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_algas_hongos)).commit();
                } else if (mi.getItemId() == R.id.mF) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_fertilizantes)).commit();
                } else if (mi.getItemId() == R.id.mH) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_herramientas)).commit();
                } else if (mi.getItemId() == R.id.ventas) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_ventas)).commit();
                } else if (mi.getItemId() == R.id.postal) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_mensajeria)).commit();
                } else if (mi.getItemId() == R.id.faq) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_faq)).commit();
                } else if (mi.getItemId() == R.id.premium) {
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragment, new Fragment(R.layout.fragment_premium)).commit();
                }
            } catch (Exception e) {
                Toast.makeText(this, "ERROR", Toast.LENGTH_SHORT).show();
            }
            return true;
        });
    }

}
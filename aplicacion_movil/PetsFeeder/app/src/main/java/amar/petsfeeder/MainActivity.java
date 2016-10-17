package amar.petsfeeder;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void openAbout(View view){
        Intent i = new Intent(this, AboutActivity.class);
        startActivity(i);
    }

    public void openTimeSchedule(View view){
        Intent i = new Intent(this, TimeScheduleActivity.class);
        startActivity(i);
    }

    public void openIPConfig(View view){
        Intent i = new Intent(this, IPConfigActivity.class);
        startActivity(i);
    }

    public void openHistory(View view){
        Intent i = new Intent(this, HistoryActivity.class);
        startActivity(i);
    }

}

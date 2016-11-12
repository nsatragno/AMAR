package amar.petsfeeder;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class TimeSchedule extends AppCompatActivity {

    public static final int REQUEST_CODE = 1;

    private static final int [] botones = {
            R.id.buttonTimeSchedule1,
            R.id.buttonTimeSchedule2,
            R.id.buttonTimeSchedule3
    };

    private static final int [] textViews = {
            R.id.textViewTimeSchedule1,
            R.id.textViewTimeSchedule2,
            R.id.textViewTimeSchedule3
    };

    class BotonListener implements View.OnClickListener {

        private final int id;

        BotonListener(int id) {
            this.id = id;
        }

        @Override
        public void onClick(View v) {
            Intent intent = new Intent(TimeSchedule.this, TimePicker.class);
            startActivityForResult(intent, id);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_time_schedule);

        for (int i = 0; i < botones.length; ++i) {
            Button boton = (Button) findViewById(botones[i]);
            boton.setOnClickListener(new BotonListener(i));
        }

    }

    public void onEdit(View vista, int scheduleNumber) {

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (data == null || data.getStringExtra("hora") == null)
            return;
        TextView textView = (TextView) findViewById(textViews[requestCode]);
        textView.setText(data.getStringExtra("hora"));
    }
}

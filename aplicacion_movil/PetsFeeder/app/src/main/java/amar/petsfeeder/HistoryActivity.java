package amar.petsfeeder;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.ArrayList;


public class HistoryActivity extends AppCompatActivity {


    private ListView historyList;
    private String[] historial = {"Hora1", "Hora2"};


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_history);
        historyList = (ListView) findViewById(R.id.listViewHistory);
        ArrayAdapter<String> historyListAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, historial);
        historyList.setAdapter(historyListAdapter);
    }
}

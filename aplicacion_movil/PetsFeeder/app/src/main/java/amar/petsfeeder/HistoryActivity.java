package amar.petsfeeder;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class HistoryActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_history);
        historyList = (ListView) findViewById(R.id.listViewHistory);
        ArrayAdapter<String> historyListAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, sistemas);
        historyList.setAdapter(historyListAdapter);
    }

    private ListView historyList;
    private String[] sistemas = {"Hora1", "Hora2", "Hora3", "Hora4", "Hora5",
            "Hora6", "Hora7", "Hora8"};


}

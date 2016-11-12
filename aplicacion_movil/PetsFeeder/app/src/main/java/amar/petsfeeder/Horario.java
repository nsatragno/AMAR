package amar.petsfeeder;

/**
 * Created by misen on 31/10/2016.
 */

public class Horario {
    private int hora;
    private int minutos;



    public Horario(int hora, int minutos) {
        this.hora = hora;
        this.minutos = minutos;
    }

    public Horario(){
        this.hora = 0;
        this.minutos = 0;
    }

    public int getHora(){
        return hora;
    }

    public int getMinutos(){
        return minutos;
    }

    public void setHora(int hora){
        this.hora = hora;
    }

    public void setMinutos(int minutos){
        this.minutos = minutos;
    }

    //Se formatea el horario leido del TimePicker en la forma HH:MM.
    public String mostrarHorario() {
        String str;
        if (getHora() < 10 && getMinutos() < 10) {
            str = "0" + Integer.toString(getHora()) + ":" + "0" + Integer.toString(getMinutos());
        } else if (getHora() < 10) {
            str = "0" + Integer.toString(getHora()) + ":" + Integer.toString(getMinutos());
        } else if (getMinutos() < 10) {
            str = Integer.toString(getHora()) + ":" + "0" + Integer.toString(getMinutos());
        }
        else{
            str = Integer.toString(getHora()) + ":" + Integer.toString(getMinutos());
        }
        return str;
    }
}


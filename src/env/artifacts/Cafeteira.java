package artifacts;

import java.awt.event.ActionEvent;
import java.awt.event.WindowEvent;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import cartago.*;
import cartago.tools.GUIArtifact;

public class Cafeteira extends GUIArtifact {
    
    private InterfaceCafeteira frame;
    private CafeteiraModel cafeteira_model = new CafeteiraModel(false);
    private boolean ligada = false;
    private int agua = 0;          // Em ml
    private int poDeCafe = 0;      // Em gramas
    private String estado = "desligada"; // Estado inicial

    public void init() {
        cafeteira_model.setOn(false);
        defineObsProperty("ligada", cafeteira_model.isOn());
        // defineObsProperty("agua", agua);
        // defineObsProperty("po_de_cafe", poDeCafe);
        // defineObsProperty("estado", estado);
        create_frame();
    }
    
    public void init(boolean ligada) {
        cafeteira_model.setOn(ligada);
        defineObsProperty("ligada", cafeteira_model.isOn());
        // defineObsProperty("agua", agua);
        // defineObsProperty("po_de_cafe", poDeCafe);
        // defineObsProperty("estado", estado);
        create_frame();
    }

    void create_frame(){
        frame = new InterfaceCafeteira();
        linkActionEventToOp(frame.powerButton, "power");
        linkActionEventToOp(frame.prepararCafeButton, "prepararCafeGUI");
        linkWindowClosingEventToOp(frame, "closed");
        frame.setVisible(true);

    }

    @OPERATION
    void ligar() {
        cafeteira_model.setOn(true);
        getObsProperty("ligada").updateValue(cafeteira_model.isOn());
    }

    @OPERATION
    void desligar() {
        
    }

    @OPERATION
    void adicionarAgua(int quantidade) {
        if (quantidade > 0) {
            agua += quantidade;
            updateProperties();
        }
    }

    @OPERATION
    void adicionarCafe(int quantidade) {
        if (quantidade > 0) {
            poDeCafe += quantidade;
            updateProperties();
        }
    }

    @OPERATION
    void prepararCafe(int xicaras) {
        if (!ligada) {
            failed("A cafeteira está desligada.");
            return;
        }

        int aguaNecessaria = xicaras * 50; // 50 ml por xícara
        int cafeNecessario = xicaras * 10; // 10 g por xícara

        if (agua < aguaNecessaria) {
            estado = "sem água";
            updateProperties();
            signal("erro", "Falta de água");
            return;
        }

        if (poDeCafe < cafeNecessario) {
            estado = "sem café";
            updateProperties();
            signal("erro", "Falta de pó de café");
            return;
        }

        estado = "preparando";
        updateProperties();

        execInternalOp("finalizarCafe", aguaNecessaria, cafeNecessario, xicaras);
    }

    @INTERNAL_OPERATION
    void power(ActionEvent ev){
        System.out.println("testestetse");
        if(cafeteira_model.isOn()){
            cafeteira_model.setOn(false);
            getObsProperty("ligada").updateValue(cafeteira_model.isOn());
        } else {
            cafeteira_model.setOn(true);
            getObsProperty("ligada").updateValue(cafeteira_model.isOn());
        }
        signal("bip");
    }

    @INTERNAL_OPERATION
    void finalizarCafe(int aguaNecessaria, int cafeNecessario, int xicaras) {
        await_time(3000); // Simula o tempo para preparar o café (3 segundos)
        agua -= aguaNecessaria;
        poDeCafe -= cafeNecessario;
        estado = "pronta";
        updateProperties();
        signal("cafePronto", xicaras);
    }

    private void updateProperties() {
        getObsProperty("ligada").updateValue(ligada);
        getObsProperty("agua").updateValue(agua);
        getObsProperty("po_de_cafe").updateValue(poDeCafe);
        getObsProperty("estado").updateValue(estado);
    }
}

class CafeteiraModel {
    boolean isOn = false;

    public CafeteiraModel(boolean isOn){
        super();
        this.isOn = isOn;
    }
    
    public boolean isOn(){
        return isOn;
    }
    
    public void setOn(boolean isOn){
        this.isOn = isOn;
    }
}

class InterfaceCafeteira extends JFrame {
    public JButton powerButton, prepararCafeButton;
    public JTextField aguaInput, cafeInput, xicarasInput;
    
    public InterfaceCafeteira() {
        setTitle("Cafeteira");
        setSize(300, 400);
        
        JPanel panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
        
        powerButton = new JButton("Ligar / Desligar");
        prepararCafeButton = new JButton("Preparar Café");
        
        JLabel aguaLabel = new JLabel();
        aguaLabel.setText("Quantidade de água: ");    
        aguaInput = new JTextField(10);

        JLabel cafeLabel = new JLabel();
        cafeLabel.setText("Quantidade de café (g): ");
        cafeInput = new JTextField(10);

        JLabel xicaraLabel = new JLabel();
        xicaraLabel.setText("Número de xícaras: ");
        xicarasInput = new JTextField(10);
        
        panel.add(powerButton);
        panel.add(aguaLabel);
        panel.add(aguaInput);
        panel.add(cafeLabel);
        panel.add(cafeInput);
        panel.add(xicaraLabel);
        panel.add(xicarasInput);
        panel.add(prepararCafeButton);
        
        setContentPane(panel);
    }
}

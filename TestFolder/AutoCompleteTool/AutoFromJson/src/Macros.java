/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ecc;

import processing.app.ui.Editor;

import java.io.FileReader;
import java.util.Iterator;
import java.util.Map;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.*;

/**
 *
 * @author dahjon
 */
public class Macros {

    protected String key;
    protected String code;
    protected int carBack;

    //macro array that lists hardcoded macros
    public static Macros[] macrosList = {
        new Macros("for", "(int i=0; i < 10; i++){\n   \n}\n",14), 
        new Macros("if", "(){\n   \n}\n",9),
        new Macros("while", "(){\n   \n}\n",9),
        new Macros("do", "{\n   \n}while();\n",3),
        new Macros("switch", "(){\n   case 1:\n   break;\n   default:\n}\n",38),
        new ReplaceMacros("setup", "void setup(){\n   \n}\n",3),
        new ReplaceMacros("draw", "void draw(){\n   \n}\n",3),
        new ReplaceMacros("swing", "import javax.swing.*;\n",0),
        new ReplaceMacros("input", "JOptionPane.showInputDialog(\"\")",2, "import javax.swing.JOptionPane;\n"),
        new ReplaceMacros("output", "JOptionPane.showMessageDialog(null, \"\");",3, "import javax.swing.JOptionPane;\n"),
        new ReplaceMacros("inputstr", "String str = JOptionPane.showInputDialog(\"\");",3, "import javax.swing.JOptionPane;\n"),
        new ReplaceMacros("vTv","This is a test",0),
        new Macros("/bo1y","1Oh1Boy",7),
        new CodeSkeletonMacro(),
        new FunctionMacro()
        };
    
    public Macros(String key, String code, int carBack) {
        this.key = key;
        this.code = code;
        this.carBack = carBack;
    }
    
    //stores line breaks before macro
    protected int getNumbersOfLineBreaks(String str){
        int nr=0;
        for (int i = 0; i < str.length(); i++) {
            if(str.charAt(i)=='\n'){
                nr++;
            }
        }
        return nr;
    }
    
    //checks if string is on the correct macro
    public  boolean stringIsThisMacro(Editor editor, String sstr) {
        return key.equals(sstr);
    }

    //insert called macro into editor
    public void insert(Editor editor, int indent) {
        int nr = getNumbersOfLineBreaks(code.substring(code.length()-carBack));
        String indentStr = new String(new char[indent]).replace('\0', ' ');
        String str = code.replaceAll("\n", "\n" + indentStr);
        editor.insertText(str);
        
        int carPos=editor.getCaretOffset()-carBack-nr*indent;
        editor.getTextArea().setCaretPosition(carPos);
        
    }  
}

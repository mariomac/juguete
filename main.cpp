#include <iostream>
#include "antlr4-runtime.h"
#include "gramaticaBaseListener.h"
#include "gramaticaLexer.h"
#include "gramaticaParser.h"
#include "gramaticaListener.h"

using namespace std;
using namespace antlr4;

class TreeShapeListener: public gramaticaBaseListener {
public:
    void enterProgram(gramaticaParser::ProgramContext *context) override {
        cout << "Empezando programa: " << endl;
    }

    void exitProgram(gramaticaParser::ProgramContext *context) override {
        cout << "Parseado finiquitao" << endl;
    }

    void enterCabecera(gramaticaParser::CabeceraContext *context) override {
        cout << "Nombre del programa: " << context->CADENA()->getText() << endl;
    }

    void enterDeclVariable(gramaticaParser::DeclVariableContext *ctx) override {
        cout << "Se ha delarado una variable: " << ctx->ID_DATO()->getText();
        cout << ", del tipo " << ctx->tipoDato()->getText() << endl;
    }

    void visitErrorNode(antlr4::tree::ErrorNode *node) override {
        cerr << "Error!! ";
        cout << node->getText() << endl;
    }
};



int main() {

    ifstream stream;

    stream.open("../test1.txt", ifstream::in);

    ANTLRInputStream input(stream);
    gramaticaLexer lexer(&input);
    CommonTokenStream tokens(&lexer);
    gramaticaParser parser(&tokens);

    tree::ParseTree *tree = parser.program();
    TreeShapeListener listener;
    tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);

    return 0;
}
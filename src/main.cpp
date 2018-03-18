#include <iostream>
#include "antlr4-runtime.h"
#include "GramaticaBaseListener.h"
#include "GramaticaParser.h"
#include "GramaticaLexer.h"

using namespace std;
using namespace antlr4;

class TreeShapeListener: public GramaticaBaseListener {
public:
    void enterProgram(GramaticaParser::ProgramContext *context) override {
        cout << "Empezando programa: " << endl;
    }

    void exitProgram(GramaticaParser::ProgramContext *context) override {
        cout << "Parseado finiquitao" << endl;
    }

    void enterCabecera(GramaticaParser::CabeceraContext *context) override {
        cout << "Nombre del programa: " << context->CADENA()->getText() << endl;
    }

    void enterDeclVariable(GramaticaParser::DeclVariableContext *ctx) override {
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
    GramaticaLexer lexer(&input);
    CommonTokenStream tokens(&lexer);
    GramaticaParser parser(&tokens);

    tree::ParseTree *tree = parser.program();
    TreeShapeListener listener;
    tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);

    return 0;
}
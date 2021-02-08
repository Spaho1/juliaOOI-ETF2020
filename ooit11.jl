import Pkg; Pkg.add("Debugger");
using Debugger

using DataFrames


function izracunajET(A,P,T ,aktivnost, trajanje)
    A=Array(A);
    P=Array(P);
    T=Array(T);
    aktivnostiSaTrajanjima = Dict(zip(A, T));



end # function

function forwardPass(A, P, T)
    nula=["start"]
    A=vcat(nula, Array(A)) ;
    P=vcat("-", Array(P)) ;
    T=vcat([0], Array(T)) ;
    ET=zeros(length(A));
    aktivnostiSaTrajanjima = Dict(zip(A, T));

    df=DataFrame(aktivnostiSaTrajanjima);
    ef=Dict();#early finish
    println(df)
    for (i, a) in enumerate(A)
        es=[] #early start
        ef[a]=aktivnostiSaTrajanjima[a]
        if contains(P[i], "-")==true
          #println("nezavisna aktivnost : ", A[i])
          else
            tmp =Set(split(P[i], ","))
            println("Aktivnost ", A[i])
            for j in tmp
                #izracunajET(A,P,T,trajanje aktivnosti )
                x=strip(j)
                println("trajanje zavisnih aktivnosti ", x,": ", aktivnostiSaTrajanjima[x]+ef[a])
                push!(es, aktivnostiSaTrajanjima[x])
            end
            ET[i]=maximum(es)
        end # if
    end # for
    println(ET)

end # function

function cpm(A, P, T)
    A=Array(A);
    P=Array(P);
    T=Array(T);
    #ideja je da napravim dictionary koji će
    #čuvati ključeve akitvnosti, a vrijednosti trajanje
    #Dalje vektor P - trebam proci da spojim nezavisnosti
    ET=zeros(length(A));
    LT=zeros(length(A));
    aktivnostiSaTrajanjima = Dict(zip(A, T));
    listaOvisnosti=[];
    for (i,v) in enumerate(A)
        if contains(P[i], "-")==false
            println("zavisne aktivnosti: ", A[i])
        end # if
        tmp = split(v, ",");
        println("Lista");
        for j in tmp
            print(j, " ")
        end



    end # for
end # function

function izracunajET(A, P, T)
    A=Array(A);
    P=Array(P);
    T=Array(T);
    tabela=DataFrame(aktivnost=A,preduvjet=P, ES=zeros(length(A)), EF=T); #pocetno stanje
    bezPreduvjeta = filter(r -> any(occursin.(["-"], r.preduvjet)), tabela);#tabela bez preduvjeta
    tmp=tabela.preduvjet .!= "-";
    sPreduvjetima=tabela[tmp, :];
    transform!(sPreduvjetima, :preduvjet => ByRow(p -> split(p, ',')) => :preduvjet);
    ravnaTabela=flatten(sPreduvjetima, :preduvjet);
    #gd = groupby(ravnaTabela, :preduvjet);
    #combine(gd, :preduvjet => maximum)
    trajanjeAktivnosti = DataFrame(Dict(zip(A, T)));
    #ravnaTabela[:trajanjePreduvja]=trajanjeAktivnosti(trajanjeAktivnosti[ravnaTabela.preduvjet])
    trajanjeAktivnosti=DataFrame([[names(trajanjeAktivnosti)]; collect.(eachrow(trajanjeAktivnosti))], [:column; Symbol.(axes(trajanjeAktivnosti, 1))])
    kolone=["aktivnosti", "trajanje"];
    names!(trajanjeAktivnosti, Symbol.(kolone))
    spojeno1=innerjoin(trajanjeAktivnosti, ravnaTabela, on=[:aktivnosti=>:preduvjet])
    println(spojeno1)
    sort!(spojeno1, :aktivnost)
    println(bezPreduvjeta)


end


"""A = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];
P = [ "-", "-", "-", "C", "A", "A", "B, D", "E", "F, G"];
T = [3, 3, 2, 2, 4, 1, 4, 1, 4];
cpm(A,P,T)
forwardPass(A,P,T)"""


A = ["A", "B", "C", "D", "E", "F"];
P = ["-", "-", "A,B", "A,B","D","C,E"]
T = [6,9,8,7,10,12];
izracunajET(A,P,T);

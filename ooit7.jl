function nadji_pocetno_SZU(C, I, O)
    """ulaz: matrica c - jedinične cijene transporta
    I izvorišta - vektor
    O odredista vektor
    izlaz cijena transporta zajedno sa odgovarajucim rjesenjima u formatu
    (trosakTransporta, matricaX)
    """
    C=Matrix(C)
    I=Array(I)
    O=Array(O)

    redoviC, koloneC=size(C)
    r_i=length(I)
    r_o=length(O)
    if redoviC!=r_i
        return "broj redova matrice C nije usaglasen sa izvoristima"
    end # if
    if koloneC!=r_o
        return "broj kolona matrice C nije usaglasen sa odredistem"
    end # if
    brojRjesenja=redoviC+koloneC-1
    pronadjenihRjesenja=0
    x=zeros(redoviC, koloneC)
    #za sada radi samo balanisaran problem
    if sum(I)==sum(O)
        for i in 1:redoviC
            for j in 1:koloneC
                tmp = min(I[i], O[j])
                I[i]=I[i]-tmp
                O[j]=O[j]-tmp
                x[i, j]=tmp
                if I[i]==0
                    break
                end # if
            end #for unutrasnje
        end # for

    end # if
    return sum(x.*c),x
end # function


function nadji_pocetno_SZU1(C, I, O)
    x,y=nadji_pocetno_SZU(C,I,O);
    return x
end


function nadji_pocetno_SZU2(C, I, O)
    x,y=nadji_pocetno_SZU(C,I,O);
    return y
end
c=[8 9 4 6; 6 9 5 3;5 6 7 4]
i=[100 120 140]
o=[90 125 80 65]
Z,x=nadji_pocetno_SZU(c, i, o)


function probasda(C, I, O)
    """ulaz: matrica c - jedinične cijene transporta
    I izvorišta - vektor
    O odredista vektor
    izlaz cijena transporta zajedno sa odgovarajucim rjesenjima u formatu
    (trosakTransporta, matricaX)
    """
    C=Matrix(C)
    I=Array(I)
    O=Array(O)
    println(C)
    println(I)
    println(O)


end

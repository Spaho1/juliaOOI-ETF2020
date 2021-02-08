using LinearAlgebra

function initA(c, A, b)
    c = Array{Float64}(c)
    A = Array{Float64}(A)
    b = Array{Float64}(b)
    #potrebna nam je proširena matrica A|I
    i=1* Matrix(I, length(b), length(b))
    prosirenaMatrica=[b A i]
    #zatim nam je potrebno da dodamu funkciju cilja u tabelu
    z_c=vcat(0, c, zeros(length(b)))
    prosirenaMatrica=[prosirenaMatrica;z_c']
    return prosirenaMatrica


end

function indexUlazneVarijable(c)
    m, i=findmax(c)
    #poslije ću možda ipak vracati uredjen par - indeks vrijednost, jer je to potrebno za dalju analizu...
    return i
end


function indexIzlazneVarijable(c, A, b)
    A=Matrix(A)
    vektorKolonaP=b./A[:, indexUlazneVarijable(c)]
    println(vektorKolonaP)
    m, i=findmin(vektorKolonaP)
    #poslije ću možda ipak vracati uredjen par - indeks vrijednost, jer je to potrebno za dalju analizu...
    return i
end

function pivotElement(A,b,c)
    A=Matrix(A)
    kolona=indexUlazneVarijable(c)
    red=indexIzlazneVarijable(c,A,b)
    #println("pivot element je ", A[red,kolona])
    return A[red,kolona]
end

function pivotiranje(ulazniRjecnik, pivotRed,pivotKolona, pivot)
    pivot=Float64(pivot)
    izlazniRjecnik=Matrix(ulazniRjecnik)
    brojRedova, brojKolona=size(izlazniRjecnik)
    izlazniRjecnik[pivotRed,:]=1/pivot*izlazniRjecnik[pivotRed,:]
    #tmpRed=copy(izlazniRjecnik[pivotRed,:])
    println("pivot red je ")
    #tmpRed=tmpRed'
    #tmpRed=repeat(tmpRed,brojRedova-1)
    #tmpRed=reshape(tmpRed, (brojRedova-1, brojKolona))
    for i in 1:brojRedova
        if i==pivotRed
            continue
        end
        println("i je ", i)
        print("---------------------")
        println("faktor za množenje je")
        println(izlazniRjecnik[i, pivotKolona+1])
        izlazniRjecnik[i,:]=izlazniRjecnik[i,:]-izlazniRjecnik[pivotRed,:]*izlazniRjecnik[i,pivotKolona+1]
        println("---------------------")
        println("pivot red je: ")
        println(izlazniRjecnik[pivotRed, :])
        println("---------------------")
    end
    println("izlazniRjecnik rječnik je")
    return izlazniRjecnik
end # function

function rijesi_simplex(A, b,c)
    #treba raditi provjeru ulaznih parametara


    tabela=initA(c,A,b)

    #slucaj nema ulazne varijable - učitaj rješenje
    while findmax(c)[1]>0
        q=indexUlazneVarijable(c)
        r=indexIzlazneVarijable(c,A,b)
        pivot=pivotElement(A,b,c)
        #slucaj nema izlazne varijable - rjesenje beskonačno
        if pivot<=0
            return "rjesenje je beskonačno"
        end # if
        tabela=pivotiranje(tabela, r)

    end # while
    return tabela
end

A=[0.5 0.3; 0.1 0.2]
b=[150, 60]
c=[3, 1]
u=initA(c,A,b)
q=indexUlazneVarijable(c)
r=indexIzlazneVarijable(c,A,b)
p=pivotElement(A,b,c)
println("Početna simplex tabela je: ", initA(c,A,b))

#println(pivotElement(A,b,c))
println(pivotiranje(u,q,r,p))

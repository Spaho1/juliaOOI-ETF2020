using LinearAlgebra

function initA(c, A, b)
    c = Array{Float64}(c)
    A = Array{Float64}(A)
    b = Array{Float64}(b)
    #potrebna nam je proširena matrica A|I
    i = 1 * Matrix(I, length(b), length(b))
    prosirenaMatrica = [b A i]
    #zatim nam je potrebno da dodamu funkciju cilja u tabelu
    z_c = vcat(0, c, zeros(length(b)))
    prosirenaMatrica = [prosirenaMatrica; z_c']
    return prosirenaMatrica


end

function indexUlazneVarijable(AB)
    c = AB[end, 2:end]
    #println("Vektor c:", c)
    m, i = findmax(c)

    if m < 0
        return -1
    end
    #println("vektor kolona ulazne varijable")
    #println(AB[1:end-1,i+1])

    return i + 1
end


function indexIzlazneVarijable(AB, indeks_ulazneVarijable)
    println("izlazna varijabla")
    AB = Matrix(AB)
    b = AB[1:end-1, 1]
    println("vektor kolona b")
    println(b)
    println("vektor kolona ulazne varijable")
    println(AB[1:end-1, indeks_ulazneVarijable])
    vektorKolonaP = b ./ AB[1:end-1, indeks_ulazneVarijable]
    println("vektor kolona p")
    println(vektorKolonaP)
    m, i = findmin(vektorKolonaP)
    if m < 0
        return -1
    end
    #println("indeks izlazne varijable je: ", i+1)
    #println("vektor red ulazne varijable")
    #println(AB[i,indeks_ulazneVarijable])
    #println("izasli iz funkcije za trazenje izlazne varijable")
    return i
end


function pivotElement(AB)
    AB = Matrix(AB)
    #println("funkcija za trazenje pivot elementa")
    #println(AB)
    kolona = indexUlazneVarijable(AB)
    #println("kolona je: ", kolona)
    red = indexIzlazneVarijable(AB, kolona)
    #println("red je: ", red)
    return AB[red, kolona]
end

A = [2 1; 2 3; 3 1]
b = [18, 42, 24]
c = [3, 2]
AB = initA(c, A, b)
println("Početna simplex tabela je: ", initA(c, A, b))
println("indeks ulazne varijable je: ", indexUlazneVarijable(AB))
#indexIzlazneVarijable(AB, indexUlazneVarijable(AB))
println(
    "indeks izlazne varijable je: ",
    indexIzlazneVarijable(AB, indexUlazneVarijable(AB)),
)
p = pivotElement(AB)

function pivotiranje(ulazniRjecnik, pivotRed, pivotKolona, pivot)
    pivot = Float64(pivot)
    izlazniRjecnik = Matrix(ulazniRjecnik)
    println(ulazniRjecnik, " ", pivotRed, " ", pivotKolona, " ", pivot)
    brojRedova, brojKolona = size(izlazniRjecnik)
    izlazniRjecnik[pivotRed, :] = 1 / pivot * izlazniRjecnik[pivotRed, :]
    for i = 1:brojRedova
        if i == pivotRed
            continue
        end
        izlazniRjecnik[i, :] =
            izlazniRjecnik[i, :] -
            izlazniRjecnik[pivotRed, :] * izlazniRjecnik[i, pivotKolona]
    end
    return izlazniRjecnik
end # function


function rijesi_simplex(A, b, c)
    #treba raditi provjeru ulaznih parametara
    redoviA, koloneA = size(A)
    dimenzijaB = length(b)
    dimenzijaC = length(c)
    if koloneA != dimenzijaC
        return "format matrice A nije saglasan sa vektorom c"
    end

    if redoviA != dimenzijaB
        return "format matrice A nije saglasan sa vektorom b"
    end
    baza=transpose(collect([redoviA+1:koloneA+redoviA]))
    println(baza)
    tabela = initA(c, A, b)
    #slucaj nema ulazne varijable - učitaj rješenje
    i = 1
    while findmax(c)[1] > 0
        println(i, " tabela ", tabela)
        q = indexUlazneVarijable(tabela)
        r = indexIzlazneVarijable(tabela, indexUlazneVarijable(tabela))
        pivot = pivotElement(tabela)
        #zraka smrti
        if r < 0
            return "rjesenje je beskonačno"
        end
        tabela = pivotiranje(tabela, r, q, pivot)
        c = tabela[end, :]
        if findmax(c)[1] < 0
            break
        end
        i = i + 1

        if i == 5
            break
        end

    end # while
    return tabela
end
rijesi_simplex(A, b, c)

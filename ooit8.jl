function rasporedi(M)
    M=Array{Float64}(M)
    redovi, kolone=size(M)
    minimumRedova = minimum(M,dims=2)
    pomnozena1=(minimumRedova'.*ones(size(M))')'
    tmpM1=M-pomnozena1
    minimumKolona = minimum(tmpM1,dims=1)
    pomnozena2=(minimumKolona'.*ones(size(M))')'
    tmpM2=tmpM1-pomnozena2
    nule=tmpM2.==0
    sumaRedova=sum(nule, dims=1)
    sumaKolona=sum(nule, dims=2)
    tmpRaspored=deepcopy(nule)
    println("na pocetku")
    println(tmpRaspored)
    for i=1:redovi
        v, j=findmax(nule[i,:])
        println("i je: ", i, " j je:", j)
        println("suma redova je: ", sumaRedova[i], " sumaKolona j je:", sumaKolona[j])
        while sumaRedova[i].>1 && sumaKolona[j].>1
            println("i je: ", i, " j je:", j)
            tmpRaspored[i,j]=0
            sumaRedova=sum(tmpRaspored, dims=1)
            sumaKolona=sum(tmpRaspored, dims=2)
        end # if
    end #end inner for loop
    println("evo da vidimo kako izgleda")
    println(tmpRaspored)
    Z=sum(M[nule])

    return nule, Z
end # function

m=[80 20 23;31 40 12;61 1 1]
#minimumRedova = minimum(m,dims=2)
#println(minimumRedova)
a, b=rasporedi(m)
println(a, b)


function dajSveCvorove(G)
    #kvadratna matrica ulaz
    #izlaz lista cvorova
    G=Array(G)
    redovi, kolone=size(G);
    return collect(1:kolone);
end # function
function dajSusjede(G, i)
    G=Array(G)
    redG=G[i,:]
    listaSusjeda=[]
    for (index, value) in enumerate(redG)
        if value.>0
            push!(listaSusjeda, index)
        end
    end # for
    return listaSusjeda

end # function

function dajsveGrane(G)
    G=Array(G)
    listaGrana=[]
    cvoroviGrava=dajSveCvorove(G)
    for i in cvoroviGrava
        for j in cvoroviGrava

            if G[i,j]>0
                push!()
            end # if

        end # for

    end # for
end # function
function createMST(u, v, inMSP)
    #u i v su cvorovi, inMSP je vektor boola
    inMSP=Array(inMSP)
    if u==v
        return false
    end # if
    if (inMST[u] == false && inMST[v] == false)
        return false;
        elseif (inMST[u] == true && inMST[v] == true)
            return false
    end
end # function

function Prim(G)
    #inicjalizacija
    cvoroviG=dajSveCvorove(G);
    brojCvorova=length(cvoroviG);
    #key = Array{Float64}(undef, brojCvorova);
    #key = [Inf for x in cvoroviG]
    #prev= Array{Float64}(undef, brojCvorova);
    #prev=[undef  for x in cvoroviG];
    #key[1]=0;
    #prev[1]
    inMST=Array{Bool}(undef, brojCvorova);
    inMST=[false  for x in cvoroviG];
    inMST[1]=true
    no_edge=0;
    costMSP=0;
    while no_edge<brojCvorova-1
        tmpMin=Inf;
        a=-1;
        b=-1;
        for i in brojCvorova
            for j in brojCvorova
                if G[i,j]<tmpMin
                    if createMST(i, j, inMST)
                        tmpMin = cost[i][j];
                        a = i;
                        b = j;
                    end # if
                end # if
            end #unutrasnji for
        end #vanjski
        if a>0&&b>0
            costMSP =costMSP+ tmpMin;
            inMST[a]=true;
            inMST[b]=true;
        end # if


    end # while
    println("suma je ", costMSP)

end # function

M = [0 6 2 0 0 0; 0 0 3 3 0 0; 0 5 0 0 1 0; 0 0 4 0 0 3; 0 1 0 0 0 2; 0 6 2 0 0 0]
Prim(M)

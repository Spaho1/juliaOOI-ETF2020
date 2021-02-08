using LinearAlgebra

function tmpSigns(tmp)
    status=0
    try
        tmp=Array{Int8}(tmp)
    catch
        status=5
        tmp=NaN
    end
    tmptmp=abs.(tmp)
    if findfirst(x -> x>1, tmptmp)!=nothing
       status=5
    end
    return tmp, status
end # function

function initABC(A, b, c, csigns, vsigns)
    c = Array{Float64}(c)
    A = Array{Float64}(A)
    b = Array{Float64}(b)
    #potrebna nam je proširena matrica A|I
    i=1* Matrix(I, length(b), length(b))
    prosirenaMatrica=[b A i]
    #zatim nam je potrebno da dodamu funkciju cilja u tabelu
    z_c=vcat(0, c, zeros(length(b)))
    prosirenaMatrica=[prosirenaMatrica;z_c']
    z_c=vcat(0, vsigns, zeros(length(b)))
    prosirenaMatrica=[prosirenaMatrica;z_c']
    return prosirenaMatrica
end


function rijesi_simplex(goal, A, b, c, csigns, vsigns)
    #ovaj dio se razlikuje izmedju zadatka u tutorijalu i u zadaci u zadaci su parametri
    #Z,X,Xd,Y,Yd,status=general_simplex(goal,c,A,b,csigns,vsigns) - Z, X, Xd, i ostalo nek stoje za sada
    #u zadaci su csigns i vsigns default paramtetri
    Z=NaN
    X=0
    Xd=0
    Y=0
    Yd=0

    goal=string(goal)
    c = Array{Float64}(c)
    A = Array{Float64}(A)
    b = Array{Float64}(b)

    redoviA, koloneA=size(A)
    dimenzijaB=length(b) #broj ograničenja
    dimenzijaC=length(c) #broj promjenjivih
    if koloneA!=dimenzijaC
        status=5
        return Z,X,Xd,Y,Yd, status
    end

    if redoviA !=dimenzijaB
        status=5
        return Z,X,Xd,Y,Yd, status
    end

    status=0
    if lowercase(goal)=="min"
        c=-c
    elseif lowercase(goal)=="max"
        return "max"
    else
        status=5
    end
    csigns, status=tmpSigns(csigns)
    if status==5 || length(csigns)!=dimenzijaB #csigns Vektor čiji su elementi isključivo +1, -1 ili 0
        #(svaka druga vrijednost signalizira grešku) i koji ima onoliko elemenata koliko ima ograničenja

        return Z,X,Xd,Y,Yd,status
    end
    vsigns, status=tmpSigns(vsigns)
    if status==5 || length(vsigns)!=dimenzijaC
        return Z,X,Xd,Y,Yd, status
    end




end # function


A=[2 1;2 3;3 1]
b=[18, 42, 24]
c=[3, 2]
csigns=[-1, -1]
vsigns=[1, 1]
AB=initABC(A,b,c, csigns, vsigns)
println(AB)

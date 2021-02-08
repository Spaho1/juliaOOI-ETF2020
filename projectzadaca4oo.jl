using Pkg
Pkg.add("ProjectManagement")
using ProjectManagement
proj = Project(
    (
        start=0,
        a=PertBeta(20,21,23),
        b=PertBeta(23,29,32),
        c=PertBeta(59,61,67),
        d=PertBeta(39,39,42),
        e=PertBeta(25,34,36),
        f=PertBeta(58,67,67),
        g=PertBeta(36, 40, 41),
        h=PertBeta(46, 46, 55),
        finish=0,
    ),
    [
        :start .=> [:a, :c, :e];
        :a .=> [:b, :g];
        [:a, :c] .=> :d;
        [:c, :e] .=> :f;
        [:b, :d, :f] .=> :h;
        [:h, :g] .=> :finish;
    ],
)
visualize_chart(proj; fontsize=2.5)


proj2 =  Project(
    (
        start=0,
        a=PertBeta(4,4,4),
        b=PertBeta(5,5,5),
        c=PertBeta(4,4,4),
        d=PertBeta(3,3,3),
        e=PertBeta(5+4,5+4,5+4),
        f=PertBeta(7,7,7),
        g=PertBeta(2, 2, 2),
        finish=0,
    ),
    [
        :start => :a;
        :a .=> [:b, :c];
        :b => :d;
        :d => :f;
        :c=> :e;
        :e=> :g;
        [:f, :g] .=> :finish;
    ],
)

critical_path(proj2)

path_durations(proj2)[1:min(3, end)]

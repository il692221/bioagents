(register :name maasha)
(request
 :content (ONT::PERFORM
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::VERSION)) :receiver Kappa)
	    (ONT::VERSION "v1"))
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::PARSE (ONT::CODE ""))) :receiver Kappa)
	    (ONT::KAPPA (ONT::OK)) )
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::PARSE (ONT::CODE "%var: 'one' 1"))) :receiver Kappa)
	    (ONT::KAPPA (ONT::OK)))
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::PARSE (ONT::CODE "A(x!1),B(x!1) -> A(x),B(x) @ 0.01"))) :receiver Kappa)
	    (ONT::ERRORS ("Error at line 1, characters 0-1: : \"A\" is not a declared agent.")) )
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::PARSE (ONT::CODE "A(x)"))) :receiver Kappa)
	    (ONT::ERRORS ("Error at line 1, characters 4-4: : Syntax error")))
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::START (ONT::CODE ""))) :receiver Kappa)
	    (ONT::ERRORS ("Missing number of plot points")))
	   (ONT::TEST
	    (request :content (ONT::PERFORM :content (ONT::START (ONT::CODE "
%agent: A(x,c) # Declaration of agent A
%agent: B(x) # Declaration of B
%agent: C(x1~u~p,x2~u~p) # Declaration of C with 2 modifiable sites
'a.b' A(x),B(x) -> A(x!1),B(x!1) @ 'on_rate' #A binds B
'a..b' A(x!1),B(x!1) -> A(x),B(x) @ 'off_rate' #AB dissociation
'ab.c' A(x!_,c),C(x1~u) ->A(x!_,c!2),C(x1~u!2) @ 'on_rate' #AB binds C
'mod x1' C(x1~u!1),A(c!1) ->C(x1~p),A(c) @ 'mod_rate' #AB modifieCs x1
'a.c' A(x,c),C(x1~p,x2~u) -> A(x,c!1),C(x1~p,x2~u!1) @ 'on_rate' #A binds C on x2
'mod x2' A(x,c!1),C(x1~p,x2~u!1) -> A(x,c),C(x1~p,x2~p) @ 'mod_rate' #A modifies x2
%var: 'on_rate' 1.0E-3 # per molecule per second
%var: 'off_rate' 0.1 # per second
%var: 'mod_rate' 1 # per second
%obs: 'AB' |A(x!x.B)|
%obs: 'Cuu' |C(x1~u?,x2~u?)|
%obs: 'Cpu' |C(x1~p?,x2~u?)|
%obs: 'Cpp' |C(x1~p?,x2~p?)|
%var: 'n_ab' 1000
%obs: 'n_c' 0
%var: 'C' |C()|
%init: 'n_ab' A(),B()
%init: 'n_c' C()
%mod: [T]=10 || [false] do $ADD 10000 C()
")
                                                                 (ONT::NB_PLOT 10)
                                                                 (ONT::MAX_EVENTS 10000000)))
                     :receiver Kappa)
	    ONT::TOKEN
	   )
	   )

 :receiver Test
 :sender maasha
)


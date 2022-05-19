"
A CTCategoryTest is a test class for testing the behavior of CTCategory
"
Class {
	#name : #CTCategoryTest,
	#superclass : #TestCase,
	#category : #'Containers-Category-Tests'
}

{ #category : #tests }
CTCategoryTest >> testApplicativeBlock [

	"(+) <$> (+3) <*> (*100) $ 5"

	| blockCategory |
	blockCategory := (CTCategory block: [ :i | i * 100 ])
	                 <*>
	                 ((CTCategory block: [ :i | i + 3 ])
	                  <!> [ :i :j | i + j ]).

	self assert: blockCategory block ! 5 equals: 508.

	blockCategory := (CTCategory block: [ :i | i * 100 ])
	                 <*> ((CTCategory block: [ :i | i + 3 ])
		                  <!> [ :i :j | Array with: i with: j ]).

	self assert: blockCategory block ! 5 equals: { 8. 500 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeBlockThreeArgs [

	"(\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5"

	| blockCategory |
	blockCategory := (CTCategory block: [ :i | i / 2 ])
	                 <*> ((CTCategory block: [ :i | i * 2 ])
		                  <*> ((CTCategory block: [ :i | i + 3 ])
			                   <!> [ :i :j :k | Array with: i with: j with: k ])).

	self assert: blockCategory block ! 5 equals: { 
			8.
			10.
			(5 / 2) }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionAppendStrings [

	"(++) <$> ['ha','heh','hmm'] <*> ['?','!','.']"

	self
		assert: (CTCategory collection: { '?'. '!'. '.' })
			<*>
			((CTCategory collection: { 'ha'. 'heh'. 'hmm' })
			 <!> [ :i :j | i , j ])
		equals: (CTCategory collection:
				 #( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' )).

	self
		assert: (CTCategory collection: { '?'. '!'. '.' })
			<*> ((CTCategory collection: { 'ha'. 'heh'. 'hmm' }) <!> #,)
		equals: (CTCategory collection:
				 #( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' ))
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionOneArgBlocks [

	"[(*0),(+100),(^2)] <*> [1,2,3]"

	self
		assert:
			(CTCategory collection: { 1. 2. 3 })
			<*> (CTCategory collection: { 
						 [ :i | i * 0 ].
						 [ :i | i + 100 ].
						 [ :i | i raisedTo: 2 ] })
		equals: (CTCategory collection: { 0. 0. 0. 101. 102. 103. 1. 4. 9 })
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionTwoArgsBlock [

	"(*) <$> [2,5,10] <*> [8,10,11]"

	self
		assert: (CTCategory collection: { 8. 10. 11 })
			<*> ((CTCategory collection: { 2. 5. 10 }) <!> [ :i :j | i * j ])
		equals: (CTCategory collection: #( 16 20 22 40 50 55 80 100 110 ))
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionTwoArgsBlocks [

	"[(+),(*)] <*> [1,2] <*> [3,4]"

	| blocks |
	blocks := CTCategory collection: { 
			          [ :i :j | i + j ].
			          [ :i :j | i * j ] }.

	self
		assert: (CTCategory collection: { 3. 4 })
			<*> ((CTCategory collection: { 1. 2 }) <*> blocks)
		equals: (CTCategory collection: { 4. 5. 5. 6. 3. 4. 6. 8 })
]

{ #category : #tests }
CTCategoryTest >> testApplicativeLiftA2ApplicativeMaybeCollection [

	"liftA2 (:) (Just 3) (Just [4])"

	| aJust |
	aJust := (CTCategory just: 3)
		         applicative: (CTCategory just: 4 ~~> nil)
		         lift: [ :obj :aLink | obj ~~> aLink ].

	self
		assert: aJust content asArray
		equals: (CTCategory just: 3 ~~> (4 ~~> nil)) content asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequence [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTCategoryMaybe sequenceA: (CTCategory just: 3)
				 ~~> ((CTCategory just: 2) ~~> ((CTCategory just: 1) ~~> nil)))
				content asArray
		equals: (CTCategory just: 3 ~~> (2 ~~> (1 ~~> nil))) content asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableJusts [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTCategoryMaybe sequenceAsequenceable: { 
					 (CTCategory just: 3).
					 (CTCategory just: 2).
					 (CTCategory just: 1) })
		equals: (CTCategory just: { 3. 2. 1 })
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCategoryCollection sequenceAsequenceable: { 
					 (CTCategory collection: { 1. 2. 3 }).
					 (CTCategory collection: { 4. 5. 6. 7 }).
					 (CTCategory collection: { 8. 9 }) })
		equals: (CTCategory collection:
				 #( #( 1 4 8 ) #( 1 4 9 ) #( 1 5 8 ) #( 1 5 9 ) #( 1 6 8 )
				    #( 1 6 9 ) #( 1 7 8 ) #( 1 7 9 ) #( 2 4 8 ) #( 2 4 9 )
				    #( 2 5 8 ) #( 2 5 9 ) #( 2 6 8 ) #( 2 6 9 ) #( 2 7 8 )
				    #( 2 7 9 ) #( 3 4 8 ) #( 3 4 9 ) #( 3 5 8 ) #( 3 5 9 )
				    #( 3 6 8 ) #( 3 6 9 ) #( 3 7 8 ) #( 3 7 9 ) ))
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableListsWithEmpty [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCategoryCollection sequenceAsequenceable: { 
					 (CTCategory collection: { 1. 2. 3 }).
					 (CTCategory collection: { 4. 5. 6. 7 }).
					 (CTCategory collection: { 8. 9 }).
					 (CTCategory collection: {  }) })
		equals: (CTCategory collection: {  })
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableUnaryBlocks [

	"sequenceA [(+3),(+2),(+1)] 3"

	self
		assert: (CTCategoryBlock sequenceAsequenceable: { 
					 (CTCategory block: [ :i | i + 3 ]).
					 (CTCategory block: [ :i | i + 2 ]).
					 (CTCategory block: [ :i | i + 1 ]) }) block ! 3
		equals: { 6. 5. 4 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: ((CTCategoryCollection sequenceA: { 
					  (CTCategory collection: { 1. 2. 3 }).
					  (CTCategory collection: { 4. 5. 6 }) } asLinkedList firstLink)
				 collection collect: #asArray)
		equals:
			#( #( 1 4 ) #( 1 5 ) #( 1 6 ) #( 2 4 ) #( 2 5 ) #( 2 6 ) #( 3 4 )
			   #( 3 5 ) #( 3 6 ) )
]

{ #category : #tests }
CTCategoryTest >> testMonadDoMaybe [

	"

foo :: Maybe String
foo = Just 3   >>= (\x ->
      Just ""!"" >>= (\y ->
		Just (show x ++ y)))
	
	"

	self
		assert: (CTCategory just: 3) >>= [ :x | 
			(CTCategory just: '!') >>= [ :y | CTCategory just: x asString , y ] ]
		equals: (CTCategory just: '3!')
]

{ #category : #tests }
CTCategoryTest >> testMonadFish [

	"
ghci> let f x = [x,-x]
ghci> let g x = [x*3,x*2]
ghci> let h = f <=< g
ghci> h 3	
	"

	| f g |
	f := [ :x | 
	     CTCategory collection: { 
			     x.
			     x negated } ].

	g := [ :x | 
	     CTCategory collection: { 
			     (x * 3).
			     (x * 2) } ].

	self
		assert: f >=> g ! 3
		equals: (CTCategory collection: { 9. -9. 6. -6 })
]

{ #category : #tests }
CTCategoryTest >> testMonadGuard [

	"guard (5 > 2) :: Maybe ()"

	self
		assert: (CTCategoryMaybe guard: 5 > 2)
		equals: (CTCategory just: nil)
]

{ #category : #tests }
CTCategoryTest >> testMonadGuardInBind [

	"[1..50] >>= (\x -> guard ('7' `elem` show x) >> return x)"

	self
		assert: (CTCategory collection: (1 to: 50)) >>= [ :each | 
			(CTCategoryCollection guard: (each asString includes: $7))
			>> (CTCategoryCollection return: each) ]
		equals: (CTCategory collection: { 7. 17. 27. 37. 47 })
]

{ #category : #tests }
CTCategoryTest >> testMonadList [

	"[3,4,5] >>= \x -> [x,-x]"

	self
		assert: (CTCategory collection: { 3. 4. 5 })
			>>= [ :x | CTCategory collection: (Array with: x with: x negated) ]
		equals: (CTCategory collection: { 3. -3. 4. -4. 5. -5 }).

	"[1,2,3] >>= \x -> []"
	self
		assert: (CTCategory collection: { 3. 4. 5 })
			>>= [ :x | CTCategory collection: {  } ]
		equals: (CTCategory collection: {  }).

	"[1,2] >>= \n -> ['a','b'] >>= \ch -> return (n, ch)"
	self
		assert: (CTCategory collection: { 1. 2 }) >>= [ :n | 
			(CTCategory collection: { $a. $b })
			>>= [ :char | 
			CTCategoryCollection return: (Array with: n with: char) ] ]
		equals:
		(CTCategory collection: #( #( 1 $a ) #( 1 $b ) #( 2 $a ) #( 2 $b ) ))
]

{ #category : #tests }
CTCategoryTest >> testMonadMaybe [

	"Just 9 >>= \x -> return (x*10)"

	self
		assert:
		(CTCategory just: 9) >>= [ :x | CTCategoryMaybe return: x * 10 ]
		equals: (CTCategory just: 9 * 10).

	self
		assert:
		CTCategory nothing >>= [ :x | CTCategoryMaybe return: x * 10 ]
		equals: CTCategory nothing
]

{ #category : #tests }
CTCategoryTest >> testMonadPierrePoleWalking [

	| pole |
	pole := CTCategoryPole new.

	self
		assert: (((pole landLeft: 1) landRight: 1) landLeft: 2) value
		equals: 3 @ 1.

	self
		assert: (pole -! [ :p | p landLeft: 1 ] -! [ :p | p landRight: 1 ]
			 -! [ :p | p landLeft: 2 ]) value
		equals: 3 @ 1.

	self
		assert: (pole maybeLandLeft: 10) value
		equals: CTCategory nothing.

	"return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2"
	self
		assert:
			(CTCategoryMaybe return: pole) >>= [ :p | p maybeLandRight: 2 ]
			>>= [ :p | p maybeLandLeft: 2 ] >>= [ :p | p maybeLandRight: 2 ]
		equals: (CTCategory just: (CTCategoryPole new
					  left: 2;
					  right: 4;
					  yourself)).

	self
		assert: (pole -! [ :p | p landLeft: 1 ] -! [ :p | p landRight: 4 ]
			 -! [ :p | p landLeft: -1 ] -! [ :p | p landRight: -2 ]) value
		equals: 0 @ 2.

	self
		assert:
			(CTCategoryMaybe return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeLandRight: 4 ] >>= [ :p | p maybeLandLeft: -1 ]
			>>= [ :p | p maybeLandRight: -2 ]
		equals: CTCategory nothing.

	self
		assert:
			(CTCategoryMaybe return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeBanana ] >>= [ :p | p maybeLandRight: 1 ]
		equals: CTCategory nothing
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendCollection [

	"[1,2,3] `mappend` [4,5,6]"

	self
		assert: ((CTCategory collection: { 1. 2. 3 }) mappend:
				 (CTCategory collection: { 4. 5. 6 }))
		equals: (CTCategory collection: { 1. 2. 3. 4. 5. 6 })
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendMaybeProduct [

	"Just (Product 3) `mappend` Just (Product 4)"

	self
		assert: ((CTCategory just: (CTCategory product: 3)) mappend:
				 (CTCategory just: (CTCategory product: 9)))
		equals: (CTCategory just: (CTCategory product: 27))
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendProduct [

	"Product 3 `mappend` Product 9"

	self
		assert: ((CTCategory product: 3) mappend: (CTCategory product: 9))
		equals: (CTCategory product: 27)
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendStrings [

	"('one' `mappend` 'two') `mappend` 'tree'"

	self
		assert: (((CTCategory collection: 'one') mappend:
				  (CTCategory collection: 'two')) mappend:
				 (CTCategory collection: 'three'))
		equals: (CTCategory collection: 'onetwothree').

	self
		assert: ((CTCategory collection: 'one') mappend:
				 ((CTCategory collection: 'two') mappend:
					  (CTCategory collection: 'three')))
		equals: (CTCategory collection: 'onetwothree')
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcat [

	"mconcat [[1,2],[3,6],[9]]"

	self
		assert: (CTCategoryCollection mconcat: { 
					 (CTCategory collection: { 1. 2 }).
					 (CTCategory collection: { 3. 6 }).
					 (CTCategory collection: { 9 }) })
		equals: (CTCategory collection: { 1. 2. 3. 6. 9 })
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcatProduct [

	"getProduct . mconcat . map Product $ [3,4,2]"

	self
		assert: (CTCategoryNumberProduct mconcat:
				 ({ 3. 4. 2 } collect: [ :each | CTCategory product: each ]))
		equals: (CTCategory product: 3 * 4 * 2)
]

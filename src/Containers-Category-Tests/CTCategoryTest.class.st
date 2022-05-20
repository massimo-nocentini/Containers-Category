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

	| anApplicative category |
	category := CTCategory block.

	anApplicative := (category on: [ :i | i * 100 ])
	                 <*>
	                 ((category on: [ :i | i + 3 ]) <!> [ :i :j | i + j ]).

	self assert: anApplicative argument ! 5 equals: 508.

	anApplicative := (category on: [ :i | i * 100 ])
	                 <*>
	                 ((category on: [ :i | i + 3 ])
	                  <!> [ :i :j | Array with: i with: j ]).

	self assert: anApplicative argument ! 5 equals: { 8. 500 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeBlockThreeArgs [

	"(\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5"

	| anApplicative category |
	category := CTCategory block.

	anApplicative := (category on: [ :i | i / 2 ])
	                 <*>
		                 ((category on: [ :i | i * 2 ])
		                  <*> ((category on: [ :i | i + 3 ])
			                   <!> [ :i :j :k | Array with: i with: j with: k ])).

	self assert: anApplicative argument ! 5 equals: { 
			8.
			10.
			(5 / 2) }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionAppendStrings [

	"(++) <$> ['ha','heh','hmm'] <*> ['?','!','.']"

	| category |
	category := CTCategory collection.

	self
		assert: (category on: { '?'. '!'. '.' })
			<*> ((category on: { 'ha'. 'heh'. 'hmm' }) <!> [ :i :j | i , j ])
		equals: (category on:
				 #( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' )).

	self
		assert: (category on: { '?'. '!'. '.' })
			<*> ((category on: { 'ha'. 'heh'. 'hmm' }) <!> #,)
		equals: (category on:
				 #( 'ha?' 'ha!' 'ha.' 'heh?' 'heh!' 'heh.' 'hmm?' 'hmm!' 'hmm.' ))
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionOneArgBlocks [

	"[(*0),(+100),(^2)] <*> [1,2,3]"

	self
		assert: { 1. 2. 3 } asCollectionCategory <*> { 
				[ :i | i * 0 ].
				[ :i | i + 100 ].
				[ :i | i raisedTo: 2 ] } asCollectionCategory
		equals: { 0. 0. 0. 101. 102. 103. 1. 4. 9 } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionTwoArgsBlock [

	"(*) <$> [2,5,10] <*> [8,10,11]"

	self
		assert: { 8. 10. 11 } asCollectionCategory
			<*> ({ 2. 5. 10 } asCollectionCategory <!> [ :i :j | i * j ])
		equals: #( 16 20 22 40 50 55 80 100 110 ) asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionTwoArgsBlocks [

	"[(+),(*)] <*> [1,2] <*> [3,4]"

	| blocks |
	blocks := { 
		          [ :i :j | i + j ].
		          [ :i :j | i * j ] } asCollectionCategory.

	self
		assert: { 3. 4 } asCollectionCategory
			<*> ({ 1. 2 } asCollectionCategory <*> blocks)
		equals: { 4. 5. 5. 6. 3. 4. 6. 8 } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeLiftA2ApplicativeMaybeCollection [

	"liftA2 (:) (Just 3) (Just [4])"

	| aJust |
	aJust := 3 asJustMaybeCategory
		         applicative: (4 ~~> nil) asJustMaybeCategory
		         lift: [ :obj :aLink | obj ~~> aLink ].

	self
		assert: aJust argument asArray
		equals: (3 ~~> (4 ~~> nil)) asJustMaybeCategory argument asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequence [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTCategory maybe new sequenceA: 3 asJustMaybeCategory
				 ~~> (2 asJustMaybeCategory ~~> (1 asJustMaybeCategory ~~> nil)))
				argument asArray
		equals:
		(3 ~~> (2 ~~> (1 ~~> nil))) asJustMaybeCategory argument asArray
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableJusts [

	"sequenceA [Just 3, Just 2, Just 1]"

	self
		assert: (CTCategory maybe new sequenceAsequenceable: { 
					 3 asJustMaybeCategory.
					 2 asJustMaybeCategory.
					 1 asJustMaybeCategory })
		equals: { 3. 2. 1 } asJustMaybeCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCategory collection new sequenceAsequenceable: ({ 
					  { 1. 2. 3 }.
					  { 4. 5. 6. 7 }.
					  { 8. 9 } } collect: [ :each | each asCollectionCategory ]))
		equals:
			#( #( 1 4 8 ) #( 1 4 9 ) #( 1 5 8 ) #( 1 5 9 ) #( 1 6 8 )
			   #( 1 6 9 ) #( 1 7 8 ) #( 1 7 9 ) #( 2 4 8 ) #( 2 4 9 )
			   #( 2 5 8 ) #( 2 5 9 ) #( 2 6 8 ) #( 2 6 9 ) #( 2 7 8 )
			   #( 2 7 9 ) #( 3 4 8 ) #( 3 4 9 ) #( 3 5 8 ) #( 3 5 9 )
			   #( 3 6 8 ) #( 3 6 9 ) #( 3 7 8 ) #( 3 7 9 ) )
				asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableListsWithEmpty [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: (CTCategory collection new sequenceAsequenceable: ({ 
					  { 1. 2. 3 }.
					  { 4. 5. 6. 7 }.
					  { 8. 9 }.
					  {  } } collect: [ :each | each asCollectionCategory ]))
		equals: {  } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceAsequenceableUnaryBlocks [

	"sequenceA [(+3),(+2),(+1)] 3"

	| category |
	category := CTCategory block.

	self
		assert: (category new sequenceAsequenceable: { 
					 (category on: [ :i | i + 3 ]).
					 (category on: [ :i | i + 2 ]).
					 (category on: [ :i | i + 1 ]) }) argument ! 3
		equals: { 6. 5. 4 }
]

{ #category : #tests }
CTCategoryTest >> testApplicativeSequenceLists [

	"sequenceA [[1,2,3],[4,5,6]]"

	self
		assert: ((CTCategory collection new sequenceA: { 
					  { 1. 2. 3 } asCollectionCategory.
					  { 4. 5. 6 } asCollectionCategory } asLinkedList firstLink)
				 argument collect: #asArray)
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
		assert: 3 asJustMaybeCategory >>= [ :x | 
			'!' asJustMaybeCategory
			>>= [ :y | (x asString , y) asJustMaybeCategory ] ]
		equals: '3!' asJustMaybeCategory
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
	     { 
		     x.
		     x negated } asCollectionCategory ].

	g := [ :x | 
	     { 
		     (x * 3).
		     (x * 2) } asCollectionCategory ].

	self
		assert: f >=> g ! 3
		equals: { 9. -9. 6. -6 } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadGuard [

	"guard (5 > 2) :: Maybe ()"

	self
		assert: (CTCategory maybe new guard: 5 > 2)
		equals: nil asJustMaybeCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadGuardInBind [

	"[1..50] >>= (\x -> guard ('7' `elem` show x) >> return x)"

	self
		assert: (1 to: 50) asCollectionCategory >>= [ :each :category | 
			(category guard: (each asString includes: $7))
			>> (category return: each) ]
		equals: { 7. 17. 27. 37. 47 } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadList [

	"[3,4,5] >>= \x -> [x,-x]"

	self
		assert: { 3. 4. 5 } asCollectionCategory
			>>= [ :x | (Array with: x with: x negated) asCollectionCategory ]
		equals: { 3. -3. 4. -4. 5. -5 } asCollectionCategory.

	"[1,2,3] >>= \x -> []"
	self
		assert: { 3. 4. 5 } asCollectionCategory
			>>= [ :x | {  } asCollectionCategory ]
		equals: {  } asCollectionCategory.

	"[1,2] >>= \n -> ['a','b'] >>= \ch -> return (n, ch)"
	self
		assert: { 1. 2 } asCollectionCategory >>= [ :n | 
			{ $a. $b } asCollectionCategory
			>>= [ :char :category | 
			category return: (Array with: n with: char) ] ]
		equals:
		#( #( 1 $a ) #( 1 $b ) #( 2 $a ) #( 2 $b ) ) asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testMonadMaybe [

	"Just 9 >>= \x -> return (x*10)"

	self
		assert:
		9 asJustMaybeCategory >>= [ :x :category | category return: x * 10 ]
		equals: (9 * 10) asJustMaybeCategory.

	self
		assert:
		CTCategory nothing >>= [ :x :category | category return: x * 10 ]
		equals: CTCategory maybe nothing
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
			(CTCategory maybe new return: pole)
			>>= [ :p | p maybeLandRight: 2 ] >>= [ :p | p maybeLandLeft: 2 ]
			>>= [ :p | p maybeLandRight: 2 ]
		equals: (CTCategoryPole new
				 left: 2;
				 right: 4;
				 yourself) asJustMaybeCategory.

	self
		assert: (pole -! [ :p | p landLeft: 1 ] -! [ :p | p landRight: 4 ]
			 -! [ :p | p landLeft: -1 ] -! [ :p | p landRight: -2 ]) value
		equals: 0 @ 2.

	self
		assert:
			(CTCategory maybe new return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeLandRight: 4 ] >>= [ :p | p maybeLandLeft: -1 ]
			>>= [ :p | p maybeLandRight: -2 ]
		equals: CTCategory maybe nothing.

	self
		assert:
			(CTCategory maybe new return: pole) >>= [ :p | p maybeLandLeft: 1 ]
			>>= [ :p | p maybeBanana ] >>= [ :p | p maybeLandRight: 1 ]
		equals: CTCategory nothing
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendCollection [

	"[1,2,3] `mappend` [4,5,6]"

	self
		assert: ({ 1. 2. 3 } asCollectionCategory mappend:
				 { 4. 5. 6 } asCollectionCategory)
		equals: { 1. 2. 3. 4. 5. 6 } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendMaybeProduct [

	"Just (Product 3) `mappend` Just (Product 4)"

	self
		assert: (3 asProductNumberCategory asJustMaybeCategory mappend:
				 9 asProductNumberCategory asJustMaybeCategory)
		equals: 27 asProductNumberCategory asJustMaybeCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendProduct [

	"Product 3 `mappend` Product 9"

	self
		assert:
		(3 asProductNumberCategory mappend: 9 asProductNumberCategory)
		equals: 27 asProductNumberCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmappendStrings [

	"('one' `mappend` 'two') `mappend` 'tree'"

	self
		assert:
			(('one' asCollectionCategory mappend: 'two' asCollectionCategory) 
				 mappend: 'three' asCollectionCategory)
		equals: 'onetwothree' asCollectionCategory.

	self
		assert: ('one' asCollectionCategory mappend:
				 ('two' asCollectionCategory mappend: 'three' asCollectionCategory))
		equals: 'onetwothree' asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcat [

	"mconcat [[1,2],[3,6],[9]]"

	self
		assert: (CTCategory collection new mconcat: { 
					 { 1. 2 } asCollectionCategory.
					 { 3. 6 } asCollectionCategory.
					 { 9 } asCollectionCategory })
		equals: { 1. 2. 3. 6. 9 } asCollectionCategory
]

{ #category : #tests }
CTCategoryTest >> testMonoidmconcatProduct [

	"getProduct . mconcat . map Product $ [3,4,2]"

	self
		assert: (CTCategory number product new mconcat:
				 ({ 3. 4. 2 } collect: [ :each | each asProductNumberCategory ]))
		equals: (3 * 4 * 2) asProductNumberCategory
]

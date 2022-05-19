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

"
A CTCategoryTest is a test class for testing the behavior of CTCategory
"
Class {
	#name : #CTCategoryTest,
	#superclass : #TestCase,
	#category : #'Containers-Category-Tests'
}

{ #category : #tests }
CTCategoryTest >> testApplicativeCollectionAppendStrings [

	"(++) <$> ['ha','heh','hmm'] <*> ['?','!','.']"

	self
		assert: (CTCategory collection: { '?'. '!'. '.' })
			<*>
			((CTCategory collection: { 'ha'. 'heh'. 'hmm' })
			 <!> [ :i :j | i , j ])
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
CTCategoryTest >> testApplicativeCollectionTwoArgsBlocks [

	"[(+),(*)] <*> [1,2] <*> [3,4]"

	| blocks |
	blocks := CTCategory collection: { 
			          [ :i :j | i + j ] currified.
			          [ :i :j | i * j ] currified }.

	self
		assert: (CTCategory collection: { 3. 4 })
			<*> ((CTCategory collection: { 1. 2 }) <*> blocks)
		equals: (CTCategory collection: { 4. 5. 5. 6. 3. 4. 6. 8 })
]

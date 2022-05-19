Trait {
	#name : #CTCategoryTApplicative,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

{ #category : #'as yet unclassified' }
CTCategoryTApplicative classSide >> pure: object [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative classSide >> sequenceA: aLink [

	"
sequenceA :: (Applicative f) => [f a] -> f [a]
sequenceA [] = pure []
sequenceA (x:xs) = (:) <$> x <*> sequenceA xs
"

	^ aLink ifNil: [ self pure: nil ] ifNotNil: [ 
		  aLink value
			  applicative: (self sequenceA: aLink nextLink)
			  lift: [ :obj :restLink | obj ~~> restLink ] ]
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative classSide >> sequenceAsequenceable: aLink [

	"
sequenceA :: (Applicative f) => [f a] -> f [a]
sequenceA [] = pure []
sequenceA (x:xs) = (:) <$> x <*> sequenceA xs
"

	^ aLink ifEmpty: [ self pure: {  } ] ifNotEmpty: [ 
		  aLink first
			  applicative: (self sequenceAsequenceable: aLink allButFirst)
			  lift: [ :obj :restLink | Array with: obj withAll: restLink ] ]
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <!> aBlock [

	^ self fmap: aBlock currified
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> <*> anApplicative [

	self explicitRequirement
]

{ #category : #'as yet unclassified' }
CTCategoryTApplicative >> applicative: anApplicative lift: aTwoArgsBlock [

	"

liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <$> a <*> b

"

	^ anApplicative <*> (self <!> aTwoArgsBlock)
]

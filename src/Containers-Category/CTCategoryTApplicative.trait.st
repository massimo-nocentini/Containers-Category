Trait {
	#name : #CTCategoryTApplicative,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

{ #category : #applicative }
CTCategoryTApplicative >> <!> aBlock [

	^ self fmap: aBlock currified
]

{ #category : #applicative }
CTCategoryTApplicative >> <*> anApplicative [

	self explicitRequirement
]

{ #category : #applicative }
CTCategoryTApplicative >> applicative: anApplicative lift: aTwoArgsBlock [

	"

liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <$> a <*> b

"

	^ anApplicative <*> (self <!> aTwoArgsBlock)
]

{ #category : #applicative }
CTCategoryTApplicative >> pure: object [

	self explicitRequirement
]

{ #category : #applicative }
CTCategoryTApplicative >> sequenceA: aLink [

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

{ #category : #applicative }
CTCategoryTApplicative >> sequenceAsequenceable: aLink [

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

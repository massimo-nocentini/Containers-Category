"
I am the trait of applicative functors. My users implement `pure:`, which wraps an object, and `<*>`, which applies wrapped blocks to wrapped objects. From these come `fmap:` and:

- `<!>`, an `fmap:` that first currifies its block, or its symbol;
- `applicative:lift:`, which applies a block of two arguments to what two applicatives wrap;
- `sequenceA:` and `sequenceAsequenceable:`, which turn a chain of links, or a sequenceable collection, of applicatives into an applicative of a chain or a collection.

The receiver of `<*>` wraps the objects and its argument the blocks, the other way round than in Haskell:

```smalltalk
({ 10. 20 } asCategory <*> ({ 1. 2 } asCategory <!> [ :i :j | i + j ])) argument ""#(11 21 12 22)""
```
"
Trait {
	#name : #TCTApplicativeCategory,
	#traits : 'TCTFunctorCategory',
	#classTraits : 'TCTFunctorCategory classTrait',
	#category : #'Containers-Category'
}

{ #category : #applicative }
TCTApplicativeCategory >> <!> aBlock [

	^ self fmap: aBlock currified
]

{ #category : #applicative }
TCTApplicativeCategory >> <*> anApplicative [

	self explicitRequirement
]

{ #category : #applicative }
TCTApplicativeCategory >> applicative: anApplicative lift: aTwoArgsBlock [

	"

liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
liftA2 f a b = f <$> a <*> b

"

	^ anApplicative <*> (self <!> aTwoArgsBlock)
]

{ #category : #functor }
TCTApplicativeCategory >> fmap: aBlock [

	^ self <*> (self pure: aBlock)
]

{ #category : #applicative }
TCTApplicativeCategory >> pure: object [

	self explicitRequirement
]

{ #category : #applicative }
TCTApplicativeCategory >> sequenceA: aLink [

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
TCTApplicativeCategory >> sequenceAsequenceable: aLink [

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

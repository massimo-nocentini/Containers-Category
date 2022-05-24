"
According to the Haskell type definition:

```haskell
data Either a b = Left a | Right b
```
"
Class {
	#name : #CTEitherCategory,
	#superclass : #CTCategory,
	#traits : 'CTCategoryTFunctor',
	#classTraits : 'CTCategoryTFunctor classTrait',
	#category : #'Containers-Category'
}

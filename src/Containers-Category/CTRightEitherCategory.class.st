"
I am the right of a `CTEitherCategory`: `fmap:` answers a right with the value of the block on my `argument`.

```smalltalk
((CTRightEitherCategory on: 3) fmap: [ :x | x + 1 ]) argument ""4""
```
"
Class {
	#name : #CTRightEitherCategory,
	#superclass : #CTEitherCategory,
	#category : #'Containers-Category'
}

{ #category : #'accessing - structure variables' }
CTRightEitherCategory >> fmap: aBlock [

	^ self class on: (aBlock cull: self argument cull: self)
]

"
I am what `asJustMaybe` answers: my `asCategory` answers a `CTJustMaybeCategory` on my object.
"
Class {
	#name : #CTCategoryJustMaybe,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryJustMaybe >> asCategory [

	^ CTJustMaybeCategory on: self object
]

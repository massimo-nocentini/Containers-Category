Class {
	#name : #CTCategoryProbabilityDistribution,
	#superclass : #CTCategoryAsCategory,
	#category : #'Containers-Category'
}

{ #category : #converting }
CTCategoryProbabilityDistribution >> asCategory [

	^ CTProbabilityDistributionCategory on: self object asCategory
]

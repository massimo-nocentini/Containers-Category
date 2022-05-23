"
class (Monoid w, Monad m) => MonadWriter w m | m -> w where
    {-# MINIMAL (writer | tell), listen, pass #-}
    -- | @'writer' (a,w)@ embeds a simple writer action.
    writer :: (a,w) -> m a
    writer ~(a, w) = do
      tell w
      return a

    -- | @'tell' w@ is an action that produces the output @w@.
    tell   :: w -> m ()
    tell w = writer ((),w)

    -- | @'listen' m@ is an action that executes the action @m@ and adds
    -- its output to the value of the computation.
    listen :: m a -> m (a, w)
    -- | @'pass' m@ is an action that executes the action @m@, which
    -- returns a value and a function, and returns the value, applying
    -- the function to the output.
    pass   :: m (a, w -> w) -> m a
"
Trait {
	#name : #CTCategoryTMonadWriter,
	#category : #'Containers-Category'
}

{ #category : #monad }
CTCategoryTMonadWriter >> listen [

	self explicitRequirement
]

{ #category : #monad }
CTCategoryTMonadWriter >> pass [

	self explicitRequirement
]

{ #category : #monad }
CTCategoryTMonadWriter >> tell: aMonoid [

	^ self writer: nil monoid: aMonoid
]

{ #category : #monad }
CTCategoryTMonadWriter >> writer: anObject monoid: aMonoid [

	self explicitRequirement
]

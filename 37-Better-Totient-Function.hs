isPrime :: Int -> Bool
isPrime n
    | n <= 1 = False
    | n == 2 || n==3 || n==5 = True
    | n `mod` 2 == 0 = False
    | otherwise = checkDivision n divisors
    where endPoint = let f = ((floor $ sqrt $ fromIntegral n)+1) in
                     if f `mod` 2 == 0 then f+1 else f
          divisors = [3,5..endPoint]
          checkDivision n [] = True
          checkDivision n [x] = n `mod` x /= 0
          checkDivision n (x:xs)
              | n `mod` x == 0 = False
              | otherwise = checkDivision n xs

primeFactorization :: Int -> [(Int,Int)]
primeFactorization x
    | x<=1 = error "n>=2 only please"
    | otherwise = [ (p, n) | p <- [2..x], x `mod` p == 0, isPrime p, n <- (maxPow p x 1) ]
    where maxPow p x n
              | x `mod` (p^n) /= 0 = [n-1]
              | otherwise = maxPow p x (n+1)

phiBetter :: Int -> Int
phiBetter 1 = 1
phiBetter n = product [ (p-1)*p^(m-1) | (p,m) <- primeFactorization n ]

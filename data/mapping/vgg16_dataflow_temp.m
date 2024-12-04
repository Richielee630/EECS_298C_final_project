Network vgg16 {
	Layer CONV1 { 
		Type: CONV
		Dimensions { K 64,C 3,R 3,S 3,Y 224,X 224 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(Sz(C),Sz(C)) C; // Adjusted to match the input channels
			TemporalMap(32,32) Y'; 
			TemporalMap(1,1) X'; // MAESTRO uses Y’ and X’ for P and Q dims
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(64, P); // No change as the layer is small
			SpatialMap(1,1) C;
		}
	}

	Layer CONV2 { 
		Type: CONV
		Dimensions { K 64,C 64,R 3,S 3,Y 224,X 224 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K; // Increase spatial parallelism
			TemporalMap(64,64) C;
			TemporalMap(32,32) Y'; // Increased spatial reuse
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(256, P); // Larger cluster to handle data
			SpatialMap(1,1) C;
		}
	}

	Layer CONV3 { 
		Type: CONV
		Dimensions { K 128,C 64,R 3,S 3,Y 112,X 112 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(4,4) K;
			TemporalMap(64,64) C;
			TemporalMap(16,16) Y'; // Reduced parallelism for better reuse
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(256, P); // Increased to better utilize hardware resources
			SpatialMap(1,1) C;
		}
	}

	Layer CONV4 { 
		Type: CONV
		Dimensions { K 128,C 128,R 3,S 3,Y 112,X 112 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(128,128) C; // Matches the layer's channel dimension
			TemporalMap(16,16) Y'; 
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(256, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV5 { 
		Type: CONV
		Dimensions { K 256,C 128,R 3,S 3,Y 56,X 56 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K; // Increase spatial parallelism
			TemporalMap(128,128) C;
			TemporalMap(16,16) Y'; // Balance parallelism and reuse
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); // Utilize more PEs
			SpatialMap(1,1) C;
		}
	}

	Layer CONV6 { 
		Type: CONV
		Dimensions { K 256,C 256,R 3,S 3,Y 56,X 56 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(256,256) C; // Adjusted for input channels
			TemporalMap(8,8) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV7 { 
		Type: CONV
		Dimensions { K 256,C 256,R 3,S 3,Y 56,X 56 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(256,256) C;
			TemporalMap(8,8) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV8 { 
		Type: CONV
		Dimensions { K 512,C 256,R 3,S 3,Y 28,X 28 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(4,4) K; // Utilize spatial parallelism for larger K
			TemporalMap(256,256) C;
			TemporalMap(8,8) Y'; // Reduce parallelism due to smaller spatial dimensions
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(1024, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV9 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 28,X 28 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(512,512) C; // Matches input channels
			TemporalMap(4,4) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(1024, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV10 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 28,X 28 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(512,512) C;
			TemporalMap(4,4) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(1024, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV11 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 14,X 14 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(512,512) C;
			TemporalMap(2,2) Y'; // Reduced for even smaller spatial dimensions
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(1024, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV12 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 14,X 14 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(512,512) C;
			TemporalMap(2,2) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(1024, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV13 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 14,X 14 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(2,2) K;
			TemporalMap(512,512) C;
			TemporalMap(2,2) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(1024, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer FC1 { 
		Type: GEMM
		Dimensions { M 4096, N 1, K 25088 }
		Dataflow {
			TemporalMap(1,1) N;
			TemporalMap(512,512) K; // Larger granularity for better reuse
			SpatialMap(2,2) M; // Parallelism in M dimension
			Cluster(4096, P); 
			SpatialMap(1,1) K;
		}
	}
	
	Layer FC2 { 
		Type: GEMM
		Dimensions { M 4096, N 1, K 4096 }
		Dataflow {
			TemporalMap(1,1) N;
			TemporalMap(256,256) K; // Increased to improve computation reuse
			SpatialMap(1,1) M;
			Cluster(4096, P); // Larger cluster for fully connected layers
			SpatialMap(1,1) K;
		}
	}

	Layer FC3 { 
		Type: GEMM
		Dimensions { M 4096, N 1, K 4096 }
		Dataflow {
			TemporalMap(1,1) N;
			TemporalMap(256,256) K; // Increased to improve computation reuse
			SpatialMap(1,1) M;
			Cluster(4096, P); // Larger cluster for fully connected layers
			SpatialMap(1,1) K;
		}
	}
}
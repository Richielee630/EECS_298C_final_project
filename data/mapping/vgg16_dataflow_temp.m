Network vgg16 {
	Layer CONV1 { 
		Type: CONV
		Dimensions { K 64,C 3,R 3,S 3,Y 224,X 224 }
		Dataflow {
			// Fill your dataflow here
			// SpatialMap(Mapping size, Spatial Offset)
			// TemporalMap(Mapping size, Temporal Offset)
			SpatialMap(1,1) K; // 64(K)/1(MappingSize) = 64PE; the MappingSize is how many data point to be process in each PE
			TemporalMap(Sz(C),Sz(C)) C; 
			TemporalMap(32,32) Y'; 
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(64, P); // Cluster(PEs_in_a_cluster) PEs_in_a_cluster should be identical as the size of C(the demention after this line), so that the dataflow will then be valid, this is from class material
			SpatialMap(1,1) C; // 3/1 = 3 PEs
			//total PE used for this layer is the product of all paralled demention PE size
			//which is K and C: 3x64 = 192PEs, our goal is to utilize all(4096) PEs for each layer
		}
	}

	Layer CONV2 { 
		Type: CONV
		Dimensions { K 64,C 64,R 3,S 3,Y 224,X 224 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(32,32) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(64, P);
			SpatialMap(1,1) C;
			//total PE used for this layer is the product of all paralled demention PE size
			//which is K and C: 64x64 = 4096PEs, which reached our goal
		}
	}

	Layer CONV3 { 
		Type: CONV
		Dimensions { K 128,C 64,R 3,S 3,Y 112,X 112 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(64,64) C;
			TemporalMap(32,32) Y'; // Reduced parallelism for better reuse
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(64, P);
			SpatialMap(1,1) C;
			//total PE used for this layer is the product of all paralled demention PE size
			//which is K and C: 128x64 = 8192PEs, it excced the maxium number of PE so the sysem will only use 4096PEs
			//based on our experiment, we have to keep K and C Mapping size to 1, which means maximize parallelism for K and C
			//other wise either the total L2 will exceed(if change K) or layer PEs decrease to 2048(if change C)
		}
	}

	Layer CONV4 { 
		Type: CONV
		Dimensions { K 128,C 128,R 3,S 3,Y 112,X 112 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(128,128) C;
			TemporalMap(16,16) Y'; 
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(128, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV5 { 
		Type: CONV
		Dimensions { K 256,C 128,R 3,S 3,Y 56,X 56 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(128,128) C;
			TemporalMap(16,16) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(128, P);
			SpatialMap(1,1) C;
		}
	}

	Layer CONV6 { 
		Type: CONV
		Dimensions { K 256,C 256,R 3,S 3,Y 56,X 56 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(256,256) C;
			TemporalMap(8,8) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(256, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV7 { 
		Type: CONV
		Dimensions { K 256,C 256,R 3,S 3,Y 56,X 56 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(256,256) C;
			TemporalMap(8,8) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(256, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV8 { 
		Type: CONV
		Dimensions { K 512,C 256,R 3,S 3,Y 28,X 28 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(256,256) C;
			TemporalMap(8,8) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(256, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV9 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 28,X 28 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(512,512) C;
			TemporalMap(4,4) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV10 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 28,X 28 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(512,512) C;
			TemporalMap(4,4) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV11 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 14,X 14 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(512,512) C;
			TemporalMap(2,2) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV12 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 14,X 14 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(512,512) C;
			TemporalMap(2,2) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer CONV13 { 
		Type: CONV
		Dimensions { K 512,C 512,R 3,S 3,Y 14,X 14 }
		Dataflow {
			// Fill your dataflow here
			SpatialMap(1,1) K;
			TemporalMap(512,512) C;
			TemporalMap(2,2) Y';
			TemporalMap(1,1) X';
			TemporalMap(Sz(R),Sz(R)) R;
			TemporalMap(Sz(S),Sz(S)) S;
			Cluster(512, P); 
			SpatialMap(1,1) C;
		}
	}

	Layer FC1 { 
		Type: GEMM
		Dimensions { M 4096, N 1, K 25088 }
		Dataflow {
			TemporalMap(1,1) N;
			TemporalMap(512,512) K;
			SpatialMap(2,2) M;
			Cluster(4096, P); 
			SpatialMap(1,1) K;
		}
	}
	
	Layer FC2 { 
		Type: GEMM
		Dimensions { M 4096, N 1, K 4096 }
		Dataflow {
			TemporalMap(1,1) N;
			TemporalMap(256,256) K;
			SpatialMap(1,1) M;
			Cluster(4096, P);
			SpatialMap(1,1) K;
		}
	}

	Layer FC3 { 
		Type: GEMM
		Dimensions { M 4096, N 1, K 4096 }
		Dataflow {
			TemporalMap(1,1) N;
			TemporalMap(256,256) K;
			SpatialMap(1,1) M;
			Cluster(4096, P);
			SpatialMap(1,1) K;
		}
	}
}
// Multi-head Attention Layer
// - A smaller variant from Llama3-8B

// <Hyperparameters>
// Number of heads (h): 4
// Model Dimension (Dk and/or Dv): 4096 
// Embedding Dimension (d): 4096
// Sequence Length (L): 1024 

Network Llama3_8B_Attention_Variant {

	// M: Sequence Length (L)
	// N: Model Dimension (Dk and/or Dv)
	// K: Embedding Dimension (d)
	Layer Q_Proj {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 4096 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Model Dimension (Dk and/or Dv)
	// K: Embedding Dimension (d)
	Layer K_Proj {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 4096 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Model Dimension (Dk/Dv)
	// K: Embedding Dimension (d)
	Layer V_Proj {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 4096 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}


	// M: Sequence Length (L)
	// N: Sequence Length (L)
	// K: Model Dimension per head (Dk/h)
	// Note that K is transposed
	Layer QK_Head1 {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Model Dimension per head (Dk/h)
	// K: Sequence Length (L)
	Layer QKV_Head1 {
		Type: GEMM
		Dimensions { M 1024, N 1024, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Sequence Length (L)
	// K: Model Dimension per head (Dk/h)
	// Note that K is transposed
	Layer QK_Head2 {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Model Dimension per head (Dk/h)
	// K: Sequence Length (L)
	Layer QKV_Head2 {
		Type: GEMM
		Dimensions { M 1024, N 1024, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Sequence Length (L)
	// K: Model Dimension per head (Dk/h)
	// Note that K is transposed
	Layer QK_Head3 {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Model Dimension per head (Dk/h)
	// K: Sequence Length (L)
	Layer QKV_Head3 {
		Type: GEMM
		Dimensions { M 1024, N 1024, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Sequence Length (L)
	// K: Model Dimension per head (Dk/h)
	// Note that K is transposed
	Layer QK_Head4 {
		Type: GEMM
		Dimensions { M 1024, N 4096, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}

	// M: Sequence Length (L)
	// N: Model Dimension per head (Dk/h)
	// K: Sequence Length (L)
	Layer QKV_Head4 {
		Type: GEMM
		Dimensions { M 1024, N 1024, K 1024 }
		Dataflow {
			TemporalMap(1,1) M;
			SpatialMap(1,1) N;
			TemporalMap(64,64) K;
			Cluster(64, P);
			SpatialMap(1,1) K;
		}
	}



}

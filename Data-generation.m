close all
clear
clc

%%
path1 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713441582146\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_001\07-06-2012-NA-PANCREAS-59677\temp';
path2 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713445228580\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_002\05-19-2012-NA-PancreasLiver DIBH 2mm-73595\301.000000-DIBH iDose 3-31781';
path3 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713629712505\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_003\01-15-2012-NA-PANCREAS-79715\2.000000-DI-87802';
path4 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713673592983\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_004\01-16-2012-NA-PANCREAS-47590\3.000000-DIBH1-84877';
path5 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713695033801\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_005\12-17-2012-NA-PANCREAS-88983\201.000000-ABDOMEN DI1 iDose 3-19971';
path6 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713695298258\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_006\07-06-2012-NA-PANCREAS-98471\201.000000-Extended FOV PANCREAS DI iDose 3-46686';
path7 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713809496446\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_007\11-29-2012-NA-PANCREAS-94944\201.000000-Extended FOV Abdomen DI 1 iDose 3-90781';
path8 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713812669720\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_008\11-08-2012-NA-PANCREAS-75939\201.000000-Abdomen DI 1 iDose 3-81434';
path9 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713818572218\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_009\11-30-2012-NA-PANCREAS-67915\201.000000-Abdomen DI 1 iDose 3-90972';
path10 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713819148168\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_010\10-13-2012-NA-CRANE 3MM-33011\201.000000-O-MAR DI1 iDose 3-04444';
path11 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713846337009\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_011\01-26-2013-NA-PANCREAS-35231\201.000000-Abdomen DI 1 iDose 3-96210';
path12 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713847838007\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_012\11-16-2012-NA-CRANE 3MM-92264\301.000000-DI1 iDose 3-01054';
path13 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713860837753\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_013\02-08-2013-NA-GI-08529\201.000000-Extended FOV PANCREAS DI 1 iDose 3-27144';
path14 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713863910593\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_014\11-17-2011-NA-UPPER GI-77417\2.000000-DI-30725';
path15 = 'C:\Users\ashwi\Desktop\Medical Imaging Datasets\manifest-1713893178802\Pancreatic-CT-CBCT-SEG\Pancreas-CT-CB_015\07-24-2011-NA-PANCREAS-27920\201.000000-DI1 iDose 3-24849';

path = {path1,path2,path3,path4,path5,path6,path7,path8,path9,path10,path11,path12,path13,path14,path15};

numFiles1 = 134;
numFiles2 = 130;
numFiles3 = 93;
numFiles4 = 194;
numFiles5 = 107;
numFiles6 = 114;
numFiles7 = 137;
numFiles8 = 136;
numFiles9 = 145;
numFiles10 = 115;
numFiles11 = 248;
numFiles12 = 112;
numFiles13 = 105;
numFiles14 = 74;
numFiles15 = 169;

numFiles = [0, numFiles1,numFiles2,numFiles3,numFiles4,numFiles5,numFiles6,numFiles7,numFiles8,numFiles9,numFiles10,numFiles11,numFiles12,numFiles13,numFiles14,numFiles15];
%%
numFile1 = 27;
numFile2 = 26;
numFile3 = 19;
numFile4 = 39;
numFile5 = 22;
numFile6 = 23;
numFile7 = 28;
numFile8 = 28;
numFile9 = 29;
numFile10 = 23;
numFile11 = 50;
numFile12 = 23;
numFile13 = 21;
numFile14 = 15;
numFile15 = 34;

numFile = [0, numFile1,numFile2,numFile3,numFile4,numFile5,numFile6,numFile7,numFile8,numFile9,numFile10,numFile11,numFile12,numFile13,numFile14,numFile15];

%%

joined_data = zeros(222,246,16*sum(numFile),2,'single');

%%
p = 1;
for filenum = 2:16
    for m = 1:5:numFiles(filenum)
        if filenum == 4 || filenum == 15
        filename = sprintf('1-%02d.dcm', m);
        else
        filename = sprintf('1-%03d.dcm', m);
        end
        disp(filenum);
        filePath = fullfile(path{filenum-1}, filename);
        xtrue512 = dicomread(filePath);
        xtrue512 = double(xtrue512);
        maxi = 3500;
        xtrue512_norm = xtrue512/maxi;

        ig_big = image_geom('nx', 512, 'fov', 35, 'down', 1);
        sg = sino_geom('ge1', 'units', 'cm', 'strip_width', 'd', 'down', 1);
        Abig = Gtomo_nufft_new(sg, ig_big);
        sino_true1 = Abig * xtrue512_norm;
        sino_true = single(sino_true1);

        % Creating noisy sinogram

        I0 = 1e5;
        rng(0)

        yi = poisson(I0 * exp(-sino_true), 0, 'factor', 0.8); % poisson noise
        noisysino = log(I0 ./ max(yi,1)); % noisy fan-beam sinogram

        sigma_electronicNoise = sqrt(31);
        noise = randn(size(noisysino));
        noise = noise/norm(noise);
        noisysino = noisysino + noise;

        %Dividing the original and noisy sinogram into 16 parts
        sub_image_size_original = size(sino_true) / sqrt(16);
        sub_images_original = cell(1, 16);
        sub_image_size = size(noisysino) / sqrt(16);
        sub_images_noisy = cell(1, 16);
        k = 1;
        for i = 1:4
            for j = 1:4

                start_row = (i - 1) * sub_image_size(1) + 1;
                end_row = i * sub_image_size(1);
                start_col = (j - 1) * sub_image_size(2) + 1;
                end_col = j * sub_image_size(2);

                sub_images_noisy{1, k} = noisysino(start_row:end_row, start_col:end_col);
                sub_images_original{1, k} = sino_true(start_row:end_row, start_col:end_col);
                k = k+1;
            end
        end

        for i = 1:16
            joined_data(:,:,p,1) = sub_images_noisy{1,i};
            joined_data(:,:,p,2) = sub_images_original{1,i};
            p=p+1;
        end

    end
end

%%
h5create("mydata8.h5","/DS1",[222 246 16*sum(numFile) 2])
h5write("mydata8.h5","/DS1",joined_data);
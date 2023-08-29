include { MD5SUM } from './modules/nf-core/md5sum/main.nf'

workflow MAIN {
    take:

    main:
    input = Channel.fromPath(params.test_data['sarscov2']['illumina']['test_1_fastq_gz']).map{ file -> [ [id:file.baseName], file ] }

    MD5SUM(input)

    MD5SUM.out.checksum.collectFile(storeDir: "${params.outdir}/csv") { meta, checksum ->
        md5sum = "${params.outdir}/${checksum.fileName}"

        ["md5sum.csv", "${md5sum}\n"]
    }
}

workflow {

    MAIN()

}